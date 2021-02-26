Class Data.CountryNoshow Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property country As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 2 ];

Property noshowamount As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 3, SqlFieldName = noshow_amount ];

ClassMethod Import(pSelectMode As %Library.Integer = {$zu(115,5)}, pFileName As %Library.String(MAXLEN=""), pDelimiter As %String = ",", pQuote As %String = """", pHeaders As %Integer = 0, ByRef pRecordCount As %Integer) As %Library.Integer [ SqlProc ]
{
	set tStatementId = $SYSTEM.Util.CreateGUID(), tCounter = 0, pRecordCount = 0
	set tPreparedStatement = ##class(%SQL.DynamicStatement).Prepare(tStatementId,..#ROWTYPE,pDelimiter,pQuote,,,0,"CSV")
	if $Isobject(tPreparedStatement) {
		set tImporter = tPreparedStatement.%New(tPreparedStatement,,pFileName,pDelimiter,pQuote)
		if $Isobject(tImporter) {
			do ..%DeleteExtent(,.tDeleted,.tInstances,1)
				// burn the column headers
			for tPtr = 1:1:pHeaders { do tImporter.%Next() }
			while tImporter.%Next() {
				set tMe = ..%New()
				if 'pSelectMode {
					set tMe.country = tImporter.%GetData(1)
					set tMe.noshowamount = tImporter.%GetData(2)
				}
				elseif pSelectMode = 1 {
					set tMe.country = $s('$system.CLS.IsMthd("countryOdbcToLogical"):tImporter.%GetData(1),1:tMe.countryOdbcToLogical(tImporter.%GetData(1)))
					set tMe.noshowamount = $s('$system.CLS.IsMthd("noshowamountOdbcToLogical"):tImporter.%GetData(2),1:tMe.noshowamountOdbcToLogical(tImporter.%GetData(2)))
				}
				elseif pSelectMode = 2 {
					set tMe.country = $s('$system.CLS.IsMthd("countryDisplayToLogical"):tImporter.%GetData(1),1:tMe.countryDisplayToLogical(tImporter.%GetData(1)))
					set tMe.noshowamount = $s('$system.CLS.IsMthd("noshowamountDisplayToLogical"):tImporter.%GetData(2),1:tMe.noshowamountDisplayToLogical(tImporter.%GetData(2)))
				}
				set tStatus = tMe.%Save()
				if $$$ISOK(tStatus) { set tCounter = tCounter + 1 }
			}
		}
	}
	set %sqlcontext.%SQLCODE = 0
	set %sqlcontext.%ROWCOUNT = tCounter
	set pRecordCount = tCounter
	quit tCounter
}

Parameter ROWTYPE = "country VARCHAR(250),noshow_amount INTEGER";

Storage Default
{
<Data name="CountryNoshowDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>country</Value>
</Value>
<Value name="3">
<Value>noshowamount</Value>
</Value>
</Data>
<DataLocation>^Data.CountryNoshowD</DataLocation>
<DefaultData>CountryNoshowDefaultData</DefaultData>
<IdLocation>^Data.CountryNoshowD</IdLocation>
<IndexLocation>^Data.CountryNoshowI</IndexLocation>
<StreamLocation>^Data.CountryNoshowS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
