# org.idempiere.zk.billboard

1. Wrap https://github.com/naver/billboard.js as zk component.

2. Get latest billboard.min.js and billboard.js from https://naver.github.io/billboard.js/#download. Following Zk naming convention, rename billboard.min.js to billboard.js and rename billboard.js to billboard.src.js.

3. Get d3 from https://d3js.org/. The current version use by billboard is v6 so the corresponding link is https://d3js.org/d3.v6.js and https://d3js.org/d3.v6.min.js. Again, following Zk naming conversion, we need to rename d3.v6.js to d3.v6.src.js 
   and rename d3.v6.min.js to d3.v6.js.

4. Replace billboard.css with latest billboard.css from https://naver.github.io/billboard.js/#download.
* Add !important to padding and text-align of .bb-tooltip th and padding of .bb-tooltip td to fix conflict with zk css
* Change font-size of text.bb-chart-arcs-gauge-title from 2.7em to 1.5em.
  * Original: text.bb-chart-arcs-gauge-title {
	  dominant-baseline: middle;
	  font-size: 2.7em; }
  * Updated: text.bb-chart-arcs-gauge-title {
	  dominant-baseline: middle;
	  font-size: 1.5em; }

5. Update version-uid in metainfo.zk/lang-addon.xml and org.idempiere.zk.billboard.Version.UID (both value must match).

6. Update version of "zul.billboard" and "zul.billboard.css" javascript-module in metainfo.zk/lang-addon.xml.
