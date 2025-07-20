# fo-report page-layout xslt package

XSLT 3.0 Package for XSL-FO Page Layout for A Report.

This report page-layout is  oneside, no-first-page-specific, no-last-page-specific.


* `fo:layout-master-set`
  * `fo:simple-page-master`
* 
* static-content

## Usage

1. Configure this package to An XSLT Tool. (In Saxon, write `<xsltPackages>` Saxon Configuretion file.)
2. In stylesheet, load package with `<xsl:use-package>`.
3. Call the templates.
   * Ordinally, `report:ins.layout-master-set` and `report:ins.static-contents`

You must override 2 templates below;

* `report:ins.running-header` ( `as="element(fo:block-container)"`)
* `report:ins.running-footer` ( `as="element(fo:block-container)"`)


### normal exmple

For example, running-header has a `<fo:retrieve-marker>` to retrieve a title which marked-up with `fo:marker` in flow-contents, and running-footer has a `<fo:page-number>` for current page-number.

```xslt
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
xmlns:report="urn:dddoooccc.org:ns:fo:report"
xmlns:fo="http://www.w3.org/1999/XSL/Format"
exclude-result-prefixes="report"
>
  <xsl:use-package name="urn:dddoooccc.org:ns:fo:report" version="*">
     <xsl:accept names="*" component="template" visibility="public"/>
     <xsl:accept names="*" component="variable" visibility="public"/>
     <xsl:accept names="*" component="attribute-set" visibility="public"/>

     <xsl:override>
       <xsl:template name="report:ins.running-header"  as="element(fo:block-container)">
         <fo:block-container
                    space-after="0.5em"
                    width="100%" height="100%" display-align="after"
                    text-align="start">
           <fo:block><fo:retrieve-marker retrieve-class-name="TITLE"/></fo:block>
         </fo:block-container>
        </xsl:template>

        <xsl:template name="report:ins.running-footer" as="element(fo:block-container)">
          <fo:block-container width="100%" height="100%" 
                    space-before="0.5em"
                    display-align="before"
                    text-align="center">
              <fo:block><fo:page-number/></fo:block>
          </fo:block-container>
        </xsl:template>
     </xsl:override>
  </xsl:use-package>


  <xsl:template match="/">
    <fo:root >
            <!-- fo:layout-master-set -->
            <xsl:call-template name="report:ins.layout-master-set"/>
                
            <fo:page-sequence master-reference="{$report:var.page-sequence-master-name.report}">
                <!-- fo:static-content* -->
                <xsl:call-template name="report:ins.static-contents"/>
                <fo:flow flow-name="{$report:var.main-body-name}">
                    <fo:block ...>
                        <!--user defined marker -->
                        <fo:wrapper marker-class-name="TITLE">TITLE</fo:wrapper>
                    </fo:block>
                <xsl:apply-templates />
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
  </xsl:template>
</xsl:stylesheet>
```


