<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:etv="urn:com.workday/etv"
    exclude-result-prefixes="xs etv"
    version="3.0">
    <xsl:output indent="no" method="text"/>
    <xsl:variable name="Separator" select="','"/> 
    <xsl:variable name="NewLine" select="'&#xD;&#xA;'"/>
    
<!--     
	<xsl:variable name="Header" select="'id,adapterType,zId,extId,extName,entity,direction,error_code,error_name,error_message,lastInboundAttempt,extDataDateTime,lastOutboundAttempt,zDataDateTime,revision,timestamp_revision,timestamp_createdByID,timestamp_lastModifiedById,timestamp_sessionId'"/>
 -->
    <xsl:variable name="Header" select="'Zimit_Id,WD_Id,extName,entity,direction,error_code,error_name,error_message,lastInboundAttempt,extDataDateTime,lastOutboundAttempt,zDataDateTime'"/>

		
	<xsl:template match="/">
	   <xsl:value-of select="$Header"/>
	   <xsl:value-of select="$NewLine"/>
	   
	   <xsl:for-each select="root/data/items/data">

<!-- 	   
            <xsl:value-of select="id"/>
			<xsl:value-of select="$Separator"/>
			
            <xsl:value-of select="adapterType"/>
			<xsl:value-of select="$Separator"/>
 -->			
			<xsl:value-of select="zId"/>
			<xsl:value-of select="$Separator"/>
			
			<xsl:value-of select="extId"/>
			<xsl:value-of select="$Separator"/>
			
			<xsl:value-of select="extName"/>
			<xsl:value-of select="$Separator"/>
			
			<xsl:value-of select="entity"/>
			<xsl:value-of select="$Separator"/>
			
			<xsl:value-of select="direction"/>						
			<xsl:value-of select="$Separator"/>
						
			<xsl:value-of select="error/code"/>
			<xsl:value-of select="$Separator"/>

			<xsl:value-of select="error/name"/>
			<xsl:value-of select="$Separator"/>

			<xsl:value-of select="error/message"/>
			<xsl:value-of select="$Separator"/>			
			
			<xsl:value-of select="lastInboundAttempt"/>
			<xsl:value-of select="$Separator"/>
						
            <xsl:value-of select="extDataDateTime"/>            
			<xsl:value-of select="$Separator"/>
			
            <xsl:value-of select="lastOutboundAttempt"/>
			<xsl:value-of select="$Separator"/>            
			
            <xsl:value-of select="zDataDateTime"/>
<!--        <xsl:value-of select="$Separator"/>
            
            <xsl:value-of select="revision"/>
            <xsl:value-of select="$Separator"/>			
			
			<xsl:value-of select="timestamp/revision"/>	
            <xsl:value-of select="$Separator"/>			
            
			<xsl:value-of select="timestamp/createdById"/>
            <xsl:value-of select="$Separator"/>			
            
			<xsl:value-of select="timestamp/lastModifiedById"/>
            <xsl:value-of select="$Separator"/>			
            
			<xsl:value-of select="timestamp/sessionId"/>
 -->			
			<xsl:value-of select="$NewLine"/>

		</xsl:for-each>
		
    </xsl:template>
</xsl:stylesheet>