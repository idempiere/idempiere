SET SQLBLANKLINES ON
SET DEFINE OFF

-- IDEMPIERE-4481 Fix problem with oracle script lines starting with @
-- Oct 3, 2020, 9:00:52 PM CEST
UPDATE AD_Element SET Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',Updated=TO_DATE('2020-10-03 21:00:52','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=283
;

-- Oct 3, 2020, 9:00:52 PM CEST
UPDATE AD_Column SET ColumnName='DisplayLogic', Name='Display Logic', Description='If the Field is displayed, the result determines if the field is actually displayed', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', Placeholder=NULL WHERE AD_Element_ID=283
;

-- Oct 3, 2020, 9:00:52 PM CEST
UPDATE AD_Process_Para SET ColumnName='DisplayLogic', Name='Display Logic', Description='If the Field is displayed, the result determines if the field is actually displayed', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', AD_Element_ID=283 WHERE UPPER(ColumnName)='DISPLAYLOGIC' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 3, 2020, 9:00:52 PM CEST
UPDATE AD_Process_Para SET ColumnName='DisplayLogic', Name='Display Logic', Description='If the Field is displayed, the result determines if the field is actually displayed', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', Placeholder=NULL WHERE AD_Element_ID=283 AND IsCentrallyMaintained='Y'
;

-- Oct 3, 2020, 9:00:52 PM CEST
UPDATE AD_InfoColumn SET ColumnName='DisplayLogic', Name='Display Logic', Description='If the Field is displayed, the result determines if the field is actually displayed', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', Placeholder=NULL WHERE AD_Element_ID=283 AND IsCentrallyMaintained='Y'
;

-- Oct 3, 2020, 9:00:52 PM CEST
UPDATE AD_Field SET Name='Display Logic', Description='If the Field is displayed, the result determines if the field is actually displayed', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=283) AND IsCentrallyMaintained='Y'
;

-- Oct 3, 2020, 9:03:37 PM CEST
UPDATE AD_Element SET Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',Updated=TO_DATE('2020-10-03 21:03:37','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=1663
;

-- Oct 3, 2020, 9:03:37 PM CEST
UPDATE AD_Column SET ColumnName='ReadOnlyLogic', Name='Read Only Logic', Description='Logic to determine if field is read only (applies only when field is read-write)', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', Placeholder=NULL WHERE AD_Element_ID=1663
;

-- Oct 3, 2020, 9:03:37 PM CEST
UPDATE AD_Process_Para SET ColumnName='ReadOnlyLogic', Name='Read Only Logic', Description='Logic to determine if field is read only (applies only when field is read-write)', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', AD_Element_ID=1663 WHERE UPPER(ColumnName)='READONLYLOGIC' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 3, 2020, 9:03:37 PM CEST
UPDATE AD_Process_Para SET ColumnName='ReadOnlyLogic', Name='Read Only Logic', Description='Logic to determine if field is read only (applies only when field is read-write)', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', Placeholder=NULL WHERE AD_Element_ID=1663 AND IsCentrallyMaintained='Y'
;

-- Oct 3, 2020, 9:03:37 PM CEST
UPDATE AD_InfoColumn SET ColumnName='ReadOnlyLogic', Name='Read Only Logic', Description='Logic to determine if field is read only (applies only when field is read-write)', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', Placeholder=NULL WHERE AD_Element_ID=1663 AND IsCentrallyMaintained='Y'
;

-- Oct 3, 2020, 9:03:37 PM CEST
UPDATE AD_Field SET Name='Read Only Logic', Description='Logic to determine if field is read only (applies only when field is read-write)', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=1663) AND IsCentrallyMaintained='Y'
;

-- Oct 3, 2020, 9:05:03 PM CEST
UPDATE AD_Element SET Help='The result determines the title to be displayed for this Window, used also as the label for Recent Items.
Format is just one or several context variables surrounded by @, examples:
<ul>
<li> @TaxID@</li>
<li> @DocumentNo@</li>
<li> @Value@ @Name@</li>
</ul>
if this field is left empty a default title/label is created using the DocumentNo, Value and Name fields if they exist.',Updated=TO_DATE('2020-10-03 21:05:03','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202611
;

-- Oct 3, 2020, 9:05:03 PM CEST
UPDATE AD_Column SET ColumnName='TitleLogic', Name='Title Logic', Description='The result determines the title to be displayed for this window', Help='The result determines the title to be displayed for this Window, used also as the label for Recent Items.
Format is just one or several context variables surrounded by @, examples:
<ul>
<li> @TaxID@</li>
<li> @DocumentNo@</li>
<li> @Value@ @Name@</li>
</ul>
if this field is left empty a default title/label is created using the DocumentNo, Value and Name fields if they exist.', Placeholder=NULL WHERE AD_Element_ID=202611
;

-- Oct 3, 2020, 9:05:04 PM CEST
UPDATE AD_Process_Para SET ColumnName='TitleLogic', Name='Title Logic', Description='The result determines the title to be displayed for this window', Help='The result determines the title to be displayed for this Window, used also as the label for Recent Items.
Format is just one or several context variables surrounded by @, examples:
<ul>
<li> @TaxID@</li>
<li> @DocumentNo@</li>
<li> @Value@ @Name@</li>
</ul>
if this field is left empty a default title/label is created using the DocumentNo, Value and Name fields if they exist.', AD_Element_ID=202611 WHERE UPPER(ColumnName)='TITLELOGIC' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 3, 2020, 9:05:04 PM CEST
UPDATE AD_Process_Para SET ColumnName='TitleLogic', Name='Title Logic', Description='The result determines the title to be displayed for this window', Help='The result determines the title to be displayed for this Window, used also as the label for Recent Items.
Format is just one or several context variables surrounded by @, examples:
<ul>
<li> @TaxID@</li>
<li> @DocumentNo@</li>
<li> @Value@ @Name@</li>
</ul>
if this field is left empty a default title/label is created using the DocumentNo, Value and Name fields if they exist.', Placeholder=NULL WHERE AD_Element_ID=202611 AND IsCentrallyMaintained='Y'
;

-- Oct 3, 2020, 9:05:04 PM CEST
UPDATE AD_InfoColumn SET ColumnName='TitleLogic', Name='Title Logic', Description='The result determines the title to be displayed for this window', Help='The result determines the title to be displayed for this Window, used also as the label for Recent Items.
Format is just one or several context variables surrounded by @, examples:
<ul>
<li> @TaxID@</li>
<li> @DocumentNo@</li>
<li> @Value@ @Name@</li>
</ul>
if this field is left empty a default title/label is created using the DocumentNo, Value and Name fields if they exist.', Placeholder=NULL WHERE AD_Element_ID=202611 AND IsCentrallyMaintained='Y'
;

-- Oct 3, 2020, 9:05:04 PM CEST
UPDATE AD_Field SET Name='Title Logic', Description='The result determines the title to be displayed for this window', Help='The result determines the title to be displayed for this Window, used also as the label for Recent Items.
Format is just one or several context variables surrounded by @, examples:
<ul>
<li> @TaxID@</li>
<li> @DocumentNo@</li>
<li> @Value@ @Name@</li>
</ul>
if this field is left empty a default title/label is created using the DocumentNo, Value and Name fields if they exist.', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202611) AND IsCentrallyMaintained='Y'
;

-- Oct 3, 2020, 9:06:20 PM CEST
UPDATE AD_Element SET Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)',Updated=TO_DATE('2020-10-03 21:06:20','YYYY-MM-DD HH24:MI:SS'),UpdatedBy=100 WHERE AD_Element_ID=202629
;

-- Oct 3, 2020, 9:06:20 PM CEST
UPDATE AD_Column SET ColumnName='ZoomLogic', Name='Zoom Logic', Description='the result determines if the zoom condition is applied', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', Placeholder=NULL WHERE AD_Element_ID=202629
;

-- Oct 3, 2020, 9:06:20 PM CEST
UPDATE AD_Process_Para SET ColumnName='ZoomLogic', Name='Zoom Logic', Description='the result determines if the zoom condition is applied', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', AD_Element_ID=202629 WHERE UPPER(ColumnName)='ZOOMLOGIC' AND IsCentrallyMaintained='Y' AND AD_Element_ID IS NULL
;

-- Oct 3, 2020, 9:06:20 PM CEST
UPDATE AD_Process_Para SET ColumnName='ZoomLogic', Name='Zoom Logic', Description='the result determines if the zoom condition is applied', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', Placeholder=NULL WHERE AD_Element_ID=202629 AND IsCentrallyMaintained='Y'
;

-- Oct 3, 2020, 9:06:20 PM CEST
UPDATE AD_InfoColumn SET ColumnName='ZoomLogic', Name='Zoom Logic', Description='the result determines if the zoom condition is applied', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', Placeholder=NULL WHERE AD_Element_ID=202629 AND IsCentrallyMaintained='Y'
;

-- Oct 3, 2020, 9:06:20 PM CEST
UPDATE AD_Field SET Name='Zoom Logic', Description='the result determines if the zoom condition is applied', Help='format := {expression} [{logic} {expression}]<br> 
expression := @{context}@{operand}{value} or @{context}@{operand}{value}<br> 
logic := {|}|{&}<br>
context := any global or window context <br>
value := strings or numbers<br>
logic operators	:= AND or OR with the previous result from left to right <br>
operand := eq{=}, gt{&gt;}, le{&lt;}, not{~^!} <br>
Examples: <br>
<ul>
<li> @AD_Table_ID@=14 | @Language@!GERGER</li>
<li> @PriceLimit@>10 | @PriceList@>@PriceActual@</li>
<li> @Name@>J</li>
</ul>
Strings may be in single quotes (optional)', Placeholder=NULL WHERE AD_Column_ID IN (SELECT AD_Column_ID FROM AD_Column WHERE AD_Element_ID=202629) AND IsCentrallyMaintained='Y'
;

SELECT register_migration_script('202010032109_IDEMPIERE-4481.sql') FROM dual
;

