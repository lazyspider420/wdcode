<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:is="java:com.workday.esb.intsys.xpath.ParsedIntegrationSystemFunctions"
    xmlns:tv="java:com.workday.esb.intsys.TypedValue" xmlns:jt="http://saxon.sf.net/java-type"
    xmlns:tube="com.capeclear.mediation.impl.cc.MediationTube"
    xmlns:ctx="com.capeclear.mediation.MediationContext" xmlns:map="java:java.util.Map"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
    
    <xsl:variable name="context" select="tube:getCurrentMediationContext()"/>
    <xsl:variable name="supplier.hash" select="ctx:getProperty($context, 'supplier.id.hash')"
        as="jt:java.util.Map"/>
    <xsl:strip-space elements="*"/>

    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="Document"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
        <Document xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <xsl:apply-templates select="*"/>
        </Document>
    </xsl:template>

    <xsl:template match="CstmrCdtTrfInitn/GrpHdr/CreDtTm"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
        <xsl:element name="CreDtTm" namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
            <xsl:variable name="time">
                <xsl:sequence
                    select="
                        translate(
                        string(
                        adjust-dateTime-to-timezone(
                        xs:dateTime(.),
                        xs:dayTimeDuration('PT0H')
                        )
                        ),
                        'TZ',
                        'T'
                        )"
                />
            </xsl:variable>
            <xsl:value-of select="substring-before($time, '.')"/>

        </xsl:element>
    </xsl:template>

    <xsl:template match="CstmrCdtTrfInitn/GrpHdr/CtrlSum"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
        <xsl:element name="CtrlSum" namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
            <xsl:value-of select="format-number(., '#.00##')"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="DbtrAgt/FinInstnId/Nm"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>
    <xsl:template match="CstmrCdtTrfInitn/GrpHdr/InitgPty/Id/OrgId/Othr"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
        <xsl:element name="BICOrBEI" namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
            <xsl:value-of select="SchmeNm/Prtry"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="PmtInf/PmtMtd"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
        <xsl:element name="PmtMtd" namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
            <xsl:value-of select="'CHK'"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="PmtInf/NbOfTxs"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"> </xsl:template>
    <xsl:template match="PmtInf/CtrlSum"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"> </xsl:template>
    <xsl:template match="PmtInf/PmtTpInf"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"> </xsl:template>
    <xsl:template match="PmtInf/Dbtr/PstlAdr/AdrTp"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"> </xsl:template>
    <xsl:template match="PmtInf/Dbtr/Id"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"> </xsl:template>
    <xsl:template match="DbtrAcct/Nm"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>
    <xsl:template match="DbtrAcct/Ccy"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>
    <xsl:template match="DbtrAcct/Tp"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>
    <xsl:template match="PmtInf/DbtrAgt/FinInstnId"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
        <xsl:element name="FinInstnId">
            <xsl:element name="ClrSysMmbId"
                namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                <xsl:element name="ClrSysId">
                    <xsl:element name="Cd">
                        <xsl:choose>
                            <xsl:when test="PstlAdr/Ctry = 'US'">
                                <xsl:value-of select="'USABA'"/>
                            </xsl:when>
                            <xsl:when test="PstlAdr/Ctry = 'CA'">
                                <xsl:value-of select="'CACPA'"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'USABA'"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="MmbId" namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                    <xsl:choose>
                        <xsl:when test="contains(ClrSysMmbId/MmbId, 'CACPA')">
                            <xsl:value-of select="substring-after(ClrSysMmbId/MmbId, 'CACPA')"/>
                        </xsl:when>
                        <xsl:when test="contains(ClrSysMmbId/MmbId, 'USABA')">
                            <xsl:value-of select="substring-after(ClrSysMmbId/MmbId, 'USABA')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="ClrSysMmbId/MmbId"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="PmtInf/BtchBookg"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>
    <xsl:template match="CstmrCdtTrfInitn/PmtInf/CdtTrfTxInf/CdtrAgt/BrnchId"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>
    <xsl:template match="PmtInf/InstrPrty"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>

    <xsl:template match="CdtTrfTxInf"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
        <xsl:element name="CdtTrfTxInf" namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
            <xsl:element name="PmtId" namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                <xsl:copy-of select="PmtId/EndToEndId"/>
            </xsl:element>
            <xsl:element name="Amt"
                xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                <xsl:element name="InstdAmt">
                    <xsl:attribute name="Ccy">
                        <xsl:value-of select="Amt/InstdAmt/@Ccy"/>
                    </xsl:attribute>
                    <xsl:value-of select="format-number(Amt/InstdAmt, '#.00##')"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="ChqInstr" namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                <xsl:element name="ChqTp" namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                    <xsl:value-of select="'CCHQ'"/>
                </xsl:element>
 
                <xsl:element name="ChqNb" namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                    <xsl:choose>
                        <xsl:when test="contains(PmtId/EndToEndId, '-')">
                            <xsl:value-of select="substring-after(PmtId/EndToEndId, '-')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="PmtId/EndToEndId"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:element>
                
                <xsl:element name="DlvryMtd"
                    namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                    <xsl:element name="Prtry"
                        namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                        <xsl:choose>
                            <xsl:when test="CalculatedField">
                                <xsl:choose>
                                    <xsl:when test="CalculatedField = 'URGENT'">
                                        <xsl:value-of select="'100'"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="CalculatedField"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'100'"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
             
            <xsl:element name="Cdtr"
                xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                <xsl:copy-of select="Cdtr/Nm"/>
                <xsl:copy-of select="Cdtr/PstlAdr"/>
                <xsl:element name="Id">
                    <xsl:element name="OrgId">
                        <xsl:element name="Othr">
                            <xsl:element name="Id">
                                <xsl:variable name="supplier.id">
                                    <xsl:value-of select="Cdtr/Id/OrgId/Othr/Id"/>
                                </xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="contains($supplier.id, 'SUPPLIER_CONNECTION')">
                                        <xsl:value-of select="map:get($supplier.hash, string($supplier.id))"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$supplier.id"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:element>
                            <xsl:element name="SchmeNm">
                                <xsl:element name="Prtry">
                                    <xsl:value-of select="'VN'"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:element>
            </xsl:element>

            <xsl:element name="RmtInf"
                xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                <!--xsl:copy-of select="RmtInf/Ustrd"/-->
                
                <xsl:choose>
                    <xsl:when test="RmtInf/Ustrd">
                        <xsl:element name="Ustrd"
                        namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                            <xsl:value-of select="concat('CEPM|',RmtInf/Ustrd)" />
                    </xsl:element>
                </xsl:when>
                </xsl:choose>
                
                <xsl:for-each select="RmtInf/Strd">
                    <Strd>
                        <xsl:copy-of select="RfrdDocInf"/>
                        <xsl:copy-of select="RfrdDocAmt"/>
                        <xsl:copy-of select="CdtrRefInf"/>
                        <AddtlRmtInf>
                            <xsl:value-of select="RfrdDocInf/Nb"/>
                        </AddtlRmtInf>
                    </Strd>
                </xsl:for-each>
            </xsl:element>

        </xsl:element>
    </xsl:template>
    <xsl:template match="Dbtr/Id/OrgId/Othr/SchmeNm"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>
    <xsl:template match="CdtTrfTxInf/CdtrAgt/FinInstnId"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
        <xsl:element name="FinInstnId" namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
            <xsl:element name="ClrSysMmbId"
                namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                <xsl:element name="ClrSysId">
                    <xsl:element name="Cd">
                        <xsl:choose>
                            <xsl:when test="PstlAdr/Ctry = 'US'">
                                <xsl:value-of select="'USABA'"/>
                            </xsl:when>
                            <xsl:when test="PstlAdr/Ctry = 'CA'">
                                <xsl:value-of select="'CACPA'"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="'USABA'"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="MmbId" namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                    <xsl:value-of select="ClrSysMmbId/MmbId"/>
                </xsl:element>
            </xsl:element>
            <xsl:copy-of select="Nm"/>
            <xsl:copy-of select="PstlAdr"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="CdtTrfTxInf/Cdtr"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
        <xsl:element name="Cdtr" namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
            <xsl:copy-of select="Nm"/>
            <xsl:element name="PstlAdr">
                <xsl:choose>
                    <xsl:when test="PstlAdr">
                        <xsl:choose>
                            <xsl:when test="PstlAdr/AdrLine[1] and PstlAdr/AdrLine[2]">
                                <xsl:choose>
                                    <xsl:when test="string-length(PstlAdr/AdrLine[2]) &gt; 16">
                                        <xsl:element name="StrtNm"
                                            namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                                            <xsl:value-of
                                                select="substring(concat(PstlAdr/AdrLine[1], ' ', PstlAdr/AdrLine[2]), 1, 70)"
                                            />
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:element name="StrtNm"
                                            namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                                            <xsl:value-of
                                                select="substring(PstlAdr/AdrLine[1], 1, 70)"/>
                                        </xsl:element>
                                        <xsl:element name="BldgNb"
                                            namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                                            <xsl:value-of
                                                select="substring(PstlAdr/AdrLine[2], 1, 16)"/>
                                        </xsl:element>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:when test="PstlAdr/AdrLine[1]">
                                <xsl:element name="StrtNm"
                                    namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                                    <xsl:value-of select="substring(PstlAdr/AdrLine[1], 1, 70)"/>
                                </xsl:element>
                            </xsl:when>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="Ctry"
                            namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                            <xsl:value-of select="'CA'"/>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>

                <xsl:copy-of select="PstlAdr/PstCd"/>
                <xsl:copy-of select="PstlAdr/TwnNm"/>
                <xsl:copy-of select="PstlAdr/CtrySubDvsn"/>
                <xsl:copy-of select="PstlAdr/Ctry"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="Cdtr/Id"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>
    <xsl:template match="CdtrAcct/Tp"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>
    <xsl:template match="CdtrAcct/Ccy"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>
    <xsl:template match="Amt"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
        <xsl:element name="Amt"
            xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
            <xsl:element name="InstdAmt">
                <xsl:attribute name="Ccy">
                    <xsl:value-of select="Amt/InstdAmt/@Ccy"/>
                </xsl:attribute>
                <xsl:value-of select="format-number(Amt/InstdAmt, '#.00##')"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="Nm"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
        <xsl:element name="Nm"
            xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
            <xsl:value-of select="substring(current(), 1, 35)"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="CdtTrfTxInf/InstrForCdtrAgt"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>
    <xsl:template match="CdtTrfTxInf/Purp"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>
    <xsl:template match="CdtTrfTxInf/Tax"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/>
    <!--xsl:template match="CdtTrfTxInf/RmtInf"
        xpath-default-namespace="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03"/-->

</xsl:stylesheet>
