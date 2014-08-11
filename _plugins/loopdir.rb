# Adapted from https://gist.github.com/jgatjens/8925165

#usage:
#{% loopdir directory:images iterator:image filter:*.jpg sort:descending %}
#   <img src="{{ image }}" />
#{% endloopdir %}
 
module Jekyll
  class LoopDirectoryTag < Liquid::Block
 
    include Liquid::StandardFilters
    Syntax = /(#{Liquid::QuotedFragment}+)?/
    
    # look up variables
    # source: http://stackoverflow.com/a/8771374/1489823
    def look_up(context, name)
      lookup = context

      name.split(".").each do |value|
        lookup = lookup[value]
      end

      lookup
    end
 
    def initialize(tag_name, markup, tokens)
      @attributes = {}
 
      @attributes['directory'] = '';
      @attributes['iterator'] = 'item';
      @attributes['filter'] = 'item';
      @attributes['sort'] = 'ascending';
 
      # Parse parameters
      if markup =~ Syntax
        markup.scan(Liquid::TagAttributes) do |key, value|
          @attributes[key] = value
        end
      else
        raise SyntaxError.new("Bad options given to 'loop_directory' plugin.")
      end
 
      #if @attributes['directory'].nil?
      #   raise SyntaxError.new("You did not specify a directory for loop_directory.")
      #end
 
      super
    end
 
    def render(context)
      context.registers[:loop_directory] ||= Hash.new(0)
      
      # If the directory does not exist on disk, try interpreting it as a variable name instead of a path
      @attributes['directory'] = look_up context, @attributes['directory'] unless File.readable?(@attributes['directory'])
      if @attributes['directory'][0] == '/'
        # substring from index 1 to end of string
        @attributes['directory'] = @attributes['directory'][1..-1]
      end
      
      images = Dir.glob(File.join(@attributes['directory'], @attributes['filter']))
 
      if @attributes['sort'].casecmp( "descending" ) == 0
        # Find files and sort them reverse-lexically. This means
        # that files whose names begin with YYYYMMDD are sorted newest first.
        images.sort! {|x,y| y <=> x }
      else
        # sort normally in ascending order
        images.sort!
      end
 
      result = []
 
      context.stack do
        
        images.each { |pathname| 
          context[@attributes['iterator']] = File.basename(pathname)
          result << render_all(@nodelist, context)
        }  
 
        # return pathname
        # images.each_with_index do |item, index|
          # context[@attributes['iterator']] = item
          # result << render_all(@nodelist, context)
        # end
      end
 
      result
    end
  end
end
 
Liquid::Template.register_tag('loopdir', Jekyll::LoopDirectoryTag)
