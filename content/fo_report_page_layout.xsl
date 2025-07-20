<xsl:package xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:report="urn:dddoooccc.org:ns:fo:report"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    package-version="1.0"
    name="urn:dddoooccc.org:ns:fo:report" 
    exclude-result-prefixes="report xs">

    <xsl:expose component="attribute-set" names="*" visibility="public"/>
    <xsl:expose component="template" names="*" visibility="public"/>
    <xsl:expose component="variable" names="*" visibility="public"/>

    <xsl:variable name="report:var.page-master-name.report" as="xs:string" visibility="public"
        select="'REPORT_PAGEMASTER'"/>
    <xsl:variable name="report:var.page-master-name.report.blank" as="xs:string" visibility="public"
        select="'REPORT_PAGEMASTER_BLANK'"/>
    <xsl:variable name="report:var.page-sequence-master-name.report" as="xs:string" visibility="public" 
        select="'REPORT_PAGE_SEQUENCE_MASTER'"/>
    <xsl:variable name="report:var.running-header-name" as="xs:string" visibility="public"
        select="'REPORT_RUNNING_HEADER'"/>
    <xsl:variable name="report:var.running-footer-name" as="xs:string" visibility="public"
        select="'REPORT_RUNNING_FOOTER'"/>
    <xsl:variable name="report:var.running-left-edge-name" as="xs:string" visibility="public"
        select="'REPORT_RUNNING_LEFT_EDGE'"/>
    <xsl:variable name="report:var.running-right-edge-name" as="xs:string" visibility="public"
        select="'REPORT_RUNNING_RIGHT_EDGE'"/>
    <xsl:variable name="report:var.main-body-name" as="xs:string" visibility="public"
        select="'REPORT_BODY'"/>
    
    
    
    <xsl:variable name="report:var.page-top-margin" as="xs:string" select="'3cm'"/>
    <xsl:variable name="report:var.page-bottom-margin" as="xs:string" select="'3cm'"/>
    <xsl:variable name="report:var.page-left-margin" as="xs:string" select="'3cm'"/>
    <xsl:variable name="report:var.page-right-margin" as="xs:string" select="'3cm'"/>


    <xsl:attribute-set name="report:atts_common.fo_simple-page-master">
        <xsl:attribute name="page-width" select="'210mm'"/>
        <xsl:attribute name="page-height" select="'297mm'"/>
    </xsl:attribute-set>

    <xsl:attribute-set name="report:atts.fo_simple-page-master.report"
        use-attribute-sets="report:atts_common.fo_simple-page-master">
        <xsl:attribute name="master-name" select="$report:var.page-master-name.report"/>
    </xsl:attribute-set>

    <xsl:attribute-set name="report:atts.fo_simple-page-master.report.blank"
        use-attribute-sets="report:atts_common.fo_simple-page-master">
        <xsl:attribute name="master-name" select="$report:var.page-master-name.report.blank"/>
    </xsl:attribute-set>

    <xsl:attribute-set name="report:atts.fo_page-sequence-master.report">
        <xsl:attribute name="master-name" 
            select="$report:var.page-sequence-master-name.report"/>
    </xsl:attribute-set>

    <xsl:attribute-set name="report:atts.fo_region-before.report">
        <xsl:attribute name="extent" select="$report:var.page-top-margin"/>
    </xsl:attribute-set>

    <xsl:attribute-set name="report:atts.fo_region-after.report">
        <xsl:attribute name="extent" select="$report:var.page-bottom-margin"/>
    </xsl:attribute-set>

    <xsl:attribute-set name="report:atts.fo_region-start.report">
        <xsl:attribute name="extent" select="$report:var.page-left-margin"/>
    </xsl:attribute-set>

    <xsl:attribute-set name="report:atts.fo_region-end.report">
        <xsl:attribute name="extent" select="$report:var.page-right-margin"/>
    </xsl:attribute-set>

    <xsl:attribute-set name="report:atts.fo_region-body.report">
        <xsl:attribute name="margin-right" select="$report:var.page-right-margin"/>
        <xsl:attribute name="margin-left" select="$report:var.page-left-margin"/>
        <xsl:attribute name="margin-top" select="$report:var.page-top-margin"/>
        <xsl:attribute name="margin-bottom" select="$report:var.page-bottom-margin"/>
    </xsl:attribute-set>


    <xsl:attribute-set name="report:atts.fo_simple-page-master.report.blank">
        <xsl:attribute name="master-name" select="$report:var.page-master-name.report.blank"/>
    </xsl:attribute-set>

    <xsl:attribute-set name="report:atts.fo_conditional-page-master-reference.report">
        <xsl:attribute name="master-reference" select="$report:var.page-master-name.report"/>
        <xsl:attribute name="blank-or-not-blank" select="'not-blank'"/>
    </xsl:attribute-set>

    <xsl:attribute-set name="report:atts.fo_conditional-page-master-reference.report.blank">
        <xsl:attribute name="master-reference" select="$report:var.page-master-name.report.blank"/>
        <xsl:attribute name="blank-or-not-blank" select="'blank'"/>
    </xsl:attribute-set>


    <xsl:attribute-set name="report:atts.fo_static-content.before">
        <xsl:attribute name="flow-name" select="$report:var.running-header-name"/>
    </xsl:attribute-set>

    <xsl:attribute-set name="report:atts.fo_static-content.after">
        <xsl:attribute name="flow-name" select="$report:var.running-footer-name"/>
    </xsl:attribute-set>


    <xsl:template name="report:ins.layout-master-set">
        <fo:layout-master-set>
            <xsl:call-template name="report:ins.page-masters"/>
            <xsl:call-template name="report:ins.page-sequence-masters"/>
        </fo:layout-master-set>
    </xsl:template>

    <xsl:template name="report:ins.page-masters" as="element(fo:simple-page-master)*">

        <fo:simple-page-master xsl:use-attribute-sets="report:atts.fo_simple-page-master.report">
            <xsl:comment>REPORT PAGE MASTER</xsl:comment>
            <fo:region-before xsl:use-attribute-sets="report:atts.fo_region-before.report"/>
            <fo:region-after xsl:use-attribute-sets="report:atts.fo_region-after.report"/>
            <fo:region-start xsl:use-attribute-sets="report:atts.fo_region-start.report"/>
            <fo:region-end xsl:use-attribute-sets="report:atts.fo_region-end.report"/>
            <fo:region-body xsl:use-attribute-sets="report:atts.fo_region-body.report"/>
        </fo:simple-page-master>

        <fo:simple-page-master
            xsl:use-attribute-sets="report:atts.fo_simple-page-master.report.blank">
        <!--
        blank page has no running now
        -->
            <fo:region-body />
        </fo:simple-page-master>
    </xsl:template>

    <xsl:template name="report:ins.page-sequence-masters">
        <fo:page-sequence-master xsl:use-attribute-sets="report:atts.fo_page-sequence-master.report">
            <xsl:comment>REPORT PAGE-SEQUENCE-MASTER</xsl:comment>
            <fo:repeatable-page-master-alternatives>
                <fo:conditional-page-master-reference
                    xsl:use-attribute-sets="report:atts.fo_conditional-page-master-reference.report"/>
                <fo:conditional-page-master-reference
                    xsl:use-attribute-sets="report:atts.fo_conditional-page-master-reference.report.blank"/>
            </fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>
    </xsl:template>

    <xsl:template name="report:ins.static-contents">
        <fo:static-content xsl:use-attribute-sets="report:atts.fo_static-content.before">
            <xsl:call-template name="report:ins.running-header"/>
        </fo:static-content>
        <fo:static-content xsl:use-attribute-sets="report:atts.fo_static-content.after">
            <xsl:call-template name="report:ins.running-footer"/>
        </fo:static-content>

    </xsl:template>

    <xsl:template name="report:ins.running-header" visibility="abstract"
        as="element(fo:block-container)"/>
    <xsl:template name="report:ins.running-footer" visibility="abstract"
        as="element(fo:block-container)"/>

</xsl:package>
