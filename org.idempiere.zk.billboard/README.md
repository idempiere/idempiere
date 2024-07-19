# org.idempiere.zk.billboard

1. Wrap https://github.com/naver/billboard.js as zk component.

2. To update, replace billboard.pkgd.js and billboard.pkgd.src.js with latest billboard.pkgd.js and billboard.pkgd.min.js from https://github.com/naver/billboard.js (Note that due to naming convention of zk, billboard.pkgd.js=billboard.pkgd.min.js and billboard.pkgd.src.js=billboard.pkgd.js ).

3. To update, replace billboard.css with latest billboard.css from https://github.com/naver/billboard.js. Add !important to padding and text-align of .bb-tooltip th and padding of .bb-tooltip td to fix conflict with zk css
