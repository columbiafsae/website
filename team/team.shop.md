---
title: "Our Machine Shop"
layout: subnav.team
permalink: /team/shop/
---

<div class="columns">
  {% for i in (1..2) %}
  <img src="{{ site.baseurl }}{{ site.assets }}/team/shop-{{ i }}.jpg" width="388" height="291">
  {% endfor %}
</div>

Knickerbocker Motorsports members have access to some of the finest design and manufacturing equipment available. We’re unique in that we have our very own space in the basement of Mudd, in addition to the Mechanical Engineering department’s machine shop on the second floor.

Over the course of the school year, students learn to use 3D printing, machinable wax models, CNC mills, and more to develop precise parts for our car. Mechanical engineers get a head start in gaining hands-on experience toward their majors, while students from other departments have the opportunity of learning to use equipment they wouldn’t have been exposed to otherwise.

{% comment %}
<script type="text/javascript">
result = "Door Sensor";

var req = new XMLHttpRequest();
req.open("GET", "http://door.servebeer.com/", false);
req.send(null);
if (req.status == 200)
{
  dump(req.responseText);
}

document.getElementById("shop-status").innerHTML = result;
</script>
{% endcomment %}

<h2 id="shop-status">Door Sensor</h2>

[Find out if we’re in the shop.](http://door.servebeer.com/) We attached a Hall-effect sensor and a Raspberry Pi to the door of our shop. When you click the link, the Pi reads the sensor’s output and responds with the appropriate webpage.

## Major Equipment

<div class="columns">
  <ul>
    <li>Bridgeport CNC Mill</li>
    <li>TIG Welder</li>
    <li>Lincoln Electric MIG Welder</li>
    <li>Reciprocating saw</li>
    <li>Angle grinder</li>
    <li>Engine dynamometer</li>
    <li>Bench grinder</li>
    <li>Soldering station</li>
    <li>3D Printer</li>
    <li>Tube bender</li>
    <li>EDM machine</li>
    <li>Laser cutter</li>
  </ul>
</div>

## Major Software

<div class="columns">
  <ul>
    <li>PTC Creo</li>
    <li>SolidWorks</li>
    <li>MasterCam</li>
    <li>Optimum K</li>
    <li>MATLAB</li>
    <li>Ricardo Wave</li>
    <li>Atlassian Confluence</li>
    <li>Atlassian JIRA</li>
    <li>HotSeat Simulator</li>
    <li>Altair HyperWorks</li>
    <li>Microsoft Excel</li>
    <li>Ubuntu Server</li>
  </ul>
</div>
