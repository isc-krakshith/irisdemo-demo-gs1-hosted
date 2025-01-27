/// Transforms SDA3 HS.SDA3.Procedure to vSTU3 Procedure
Class HS.Local.FHIR.DTL.SDA3.vSTU3.Procedure.Procedure Extends Ens.DataTransformDTL [ DependsOn = (HS.SDA3.Procedure, HS.FHIR.DTL.vSTU3.Model.Resource.Procedure), ProcedureBlock ]
{

/// This DTL XData block was generated. Do not modify it.
XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.SDA3.Procedure' targetClass='HS.FHIR.DTL.vSTU3.Model.Resource.Procedure' create='existing' language='objectscript' >
  <annotation>
    <![CDATA[ Transforms HS.SDA3.Procedure (SDA3) to Procedure (vSTU3) ]]>
  </annotation>
<assign value='"unknown"' property='target.status' action='set' >
<annotation>
<![CDATA[ preparation | in-progress | suspended | aborted | completed | entered-in-error | unknown ]]>
</annotation>
</assign>
<assign value='##class(HS.FHIR.DTL.Util.SDA3.Handler.CustomPairs).Extension(source.CustomPairs, .target)' property='value' action='set' />
<assign value='target.extension.Count()+1' property='index' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/procedure-custom-pairs"' property='value.url' action='set' />
<assign value='value' property='target.extension' action='set' key='index'  >
<annotation>
<![CDATA[ Additional Content defined by implementations
 --- When the SDA3 source data contains a CustomPairs collection, and the target is FHIR, the collection is mapped to a FHIR extension that contains a Parameters resource. This Parameters resource is a collection of paired fields: name and valueString.   ]]>
</annotation>
</assign></true> 
</if> 
<if condition='&apos;##class(HS.FHIR.DTL.Util.Mapping).Exclude("ODS")'> 
<true>
<assign value='##class(HS.FHIR.DTL.Util.SDA3.Handler.Patient).Reference(aux("callbackObject"))' property='value' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.subject' action='set' >
<annotation>
<![CDATA[ Who the procedure was performed on
 --- Public API methods have a specific purpose for this field-to-field mapping. When internal system utilities invoke the DTL class for this transformation, they skip the <assign> statement generated by this mapping. The transformation produces the same target object in either case.   ]]>
</annotation>
</assign></true> 
</if> 
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "Clinician")'> 
<true>
<assign value='target.newResource.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vSTU3.Model.Resource.Practitioner).%New()' property='tmp' action='set' />
<assign value='##class(HS.FHIR.DTL.Util.Execute).ExecuteDTL("HS.Local.FHIR.DTL.SDA3.vSTU3.CodeTableDetail.CareProvider.Practitioner",source.Clinician,.tmp,.aux)' property='status' action='set' />
<code>
<![CDATA[  if $listvalid(target.newResourceReference) { set target.newResourceReference = $listupdate(target.newResourceReference, $listlength(target.newResourceReference) + 1, "performer[n].actor") } 
 else { set target.newResourceReference = $listbuild("performer[n].actor") } ]]></code>
<if condition='tmp&apos;=""'> 
<true>
<assign value='tmp' property='target.newResource' action='set' key='index'  >
<annotation>
<![CDATA[ The reference to the practitioner ]]>
</annotation>
</assign></true> 
</if>
</true> 
</if>
<foreach property='source.Devices()' key='st' >
<assign value='target.newResource.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vSTU3.Model.Resource.Device).%New()' property='tmp' action='set' />
<assign value='##class(HS.FHIR.DTL.Util.Execute).ExecuteDTL("HS.Local.FHIR.DTL.SDA3.vSTU3.Device.Device",source.Devices.(st),.tmp,.aux)' property='status' action='set' />
<code>
<![CDATA[  if $listvalid(target.newResourceReference) { set target.newResourceReference = $listupdate(target.newResourceReference, $listlength(target.newResourceReference) + 1, "usedReference") } 
 else { set target.newResourceReference = $listbuild("usedReference") } ]]></code>
<if condition='tmp&apos;=""'> 
<true>
<assign value='tmp' property='target.newResource' action='set' key='index'  >
<annotation>
<![CDATA[ Items used during procedure ]]>
</annotation>
</assign></true> 
</if>
</foreach>
<if condition='source.EncounterNumber&apos;=""'> 
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vSTU3.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='##class(HS.FHIR.DTL.Util.Execute).ExecuteDTL("HS.FHIR.DTL.SubXFrm.SDA3.vSTU3.String.Extension",source.EncounterNumber,.tmp,.aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/procedure-encounter-number"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index'  >
<annotation>
<![CDATA[ Additional Content defined by implementations ]]>
</annotation>
</assign></true> 
</if>

</true>
</if>
<if condition='&apos;##class(HS.FHIR.DTL.Util.Mapping).Exclude("ODS")'> 
<true>
<assign value='##class(HS.FHIR.DTL.Util.SDA3.Handler.ExternalId).GetHCReference("Encounter", source.EncounterNumber, aux("callbackObject"))' property='value' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.context' action='set' >
<annotation>
<![CDATA[ Encounter or episode associated with the procedure
 --- Public API methods have a specific purpose for this field-to-field mapping. When internal system utilities invoke the DTL class for this transformation, they skip the <assign> statement generated by this mapping. The transformation produces the same target object in either case.   ]]>
</annotation>
</assign></true> 
</if> 
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "EnteredAt")'> 
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vSTU3.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='##class(HS.FHIR.DTL.Util.Execute).ExecuteDTL("HS.Local.FHIR.DTL.SDA3.vSTU3.CodeTableDetail.Organization.Extension",source.EnteredAt,.tmp,.aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/procedure-entered-at"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index'  >
<annotation>
<![CDATA[ Additional Content defined by implementations ]]>
</annotation>
</assign></true> 
</if>
</true> 
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "EnteredBy")'> 
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vSTU3.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='##class(HS.FHIR.DTL.Util.Execute).ExecuteDTL("HS.Local.FHIR.DTL.SDA3.vSTU3.CodeTableDetail.Extension",source.EnteredBy,.tmp,.aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/procedure-entered-by"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index'  >
<annotation>
<![CDATA[ Additional Content defined by implementations ]]>
</annotation>
</assign></true> 
</if>
</true> 
</if>
<if condition='source.EnteredOn&apos;=""'> 
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vSTU3.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='##class(HS.FHIR.DTL.Util.Execute).ExecuteDTL("HS.FHIR.DTL.SubXFrm.SDA3.vSTU3.TimeStamp.Extension",source.EnteredOn,.tmp,.aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/procedure-entered-on"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index'  >
<annotation>
<![CDATA[ Additional Content defined by implementations ]]>
</annotation>
</assign></true> 
</if>

</true>
</if>
<assign value='##class(HS.FHIR.DTL.Util.SDA3.Handler.ExternalId).Identifier(source.ExternalId)' property='value' action='set' />
<assign value='target.identifier.Count()+1' property='index' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.identifier' action='set' key='index'  >
<annotation>
<![CDATA[ External Identifiers for this procedure ]]>
</annotation>
</assign></true> 
</if> 
<if condition='source.FromTime&apos;=""'> 
<true>
<if condition='source.ProcedureTime = ""'> 
<true>
<assign value='##class(HS.FHIR.DTL.Util.Element.TypeCast).DateToFHIR(source.FromTime, "dateTime")' property='value' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.performedPeriod.start' action='set' >
<annotation>
<![CDATA[ Starting time with inclusive boundary ]]>
</annotation>
</assign></true> 
</if> 
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "Procedure")'> 
<true>
<assign value='##class(HS.FHIR.DTL.vSTU3.Model.Datatype.CodeableConcept).%New()' property='tmp' action='set' />
<assign value='##class(HS.FHIR.DTL.Util.Execute).ExecuteDTL("HS.Local.FHIR.DTL.SDA3.vSTU3.CodeTableTranslated.CodeableConcept",source.Procedure,.tmp,.aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='tmp' property='target.code' action='set'  >
<annotation>
<![CDATA[ Identification of the procedure
 --- In this case, any FHIR3 code may be used; procedure-code shows Example codes, but you may use codes from any ValueSet. 
 --- SDA does not restrict code values to a particular set.    ]]>
</annotation>
</assign></true> 
</if>
</true> 
</if>
<assign value='##class(HS.FHIR.DTL.Util.Element.TypeCast).DateToFHIR(source.ProcedureTime, "dateTime")' property='value' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.performedDateTime' action='set' >
<annotation>
<![CDATA[ Date/Period the procedure was performed.  ]]>
</annotation>
</assign></true> 
</if> 
<if condition='source.ToTime&apos;=""'> 
<true>
<if condition='source.ProcedureTime = ""'> 
<true>
<assign value='##class(HS.FHIR.DTL.Util.Element.TypeCast).DateToFHIR(source.ToTime, "dateTime")' property='value' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.performedPeriod.end' action='set' >
<annotation>
<![CDATA[ End time with inclusive boundary, if not ongoing ]]>
</annotation>
</assign></true> 
</if> 
</true>
</if>
</true>
</if>
<if condition='##class(%Dictionary.ClassDefinition).%ExistsId("HS.FHIR.DTL.Mapping.Extension.SDA3.vSTU3.Procedure.Procedure")'> 
<true>
<code><![CDATA[  lock +^HS.FHIR.DTL("lock", "HS.FHIR.DTL.Mapping.Extension.SDA3.vSTU3.Procedure.Procedure") ]]></code>
<assign value='##class(HS.FHIR.DTL.Mapping.Extension.SDA3.vSTU3.Procedure.Procedure).Transform(source.Extension, .target, .aux)' property='target' action='set' />
<code><![CDATA[  lock -^HS.FHIR.DTL("lock", "HS.FHIR.DTL.Mapping.Extension.SDA3.vSTU3.Procedure.Procedure") ]]></code>
</true>
</if>
</transform>
}

}
