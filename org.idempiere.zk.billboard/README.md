# org.idempiere.zk.billboard

1. Wrap https://github.com/naver/billboard.js as zk component.

2. Replace billboard.pkgd.js and billboard.pkgd.src.js with latest billboard.pkgd.min.js and billboard.pkgd.js from https://github.com/naver/billboard.js (Following Zk naming convention, billboard.pkgd.js=billboard.pkgd.min.js and billboard.pkgd.src.js=billboard.pkgd.js ).

3. Replace billboard.css with latest billboard.css from https://github.com/naver/billboard.js.
* Add !important to padding and text-align of .bb-tooltip th and padding of .bb-tooltip td to fix conflict with zk css
* Change font-size of text.bb-chart-arcs-gauge-title from 2.7em to 1.5em.
  * Original: text.bb-chart-arcs-gauge-title {
	  dominant-baseline: middle;
	  font-size: 2.7em; }
  * Updated: text.bb-chart-arcs-gauge-title {
	  dominant-baseline: middle;
	  font-size: 1.5em; }

4. Update version-uid in metainfo.zk/lang-addon.xml and org.idempiere.zk.billboard.Version.UID (both value must match).

5. Update version of "zul.billboard" and "zul.billboard.css" javascript-module in metainfo.zk/lang-addon.xml.