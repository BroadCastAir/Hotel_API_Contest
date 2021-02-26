Class Data.NumPriceChannel Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property custchannel As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 2, SqlFieldName = cust_channel ];

Property roomprice As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 3, SqlFieldName = room_price ];

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
					set tMe.custchannel = tImporter.%GetData(1)
					set tMe.roomprice = tImporter.%GetData(2)
				}
				elseif pSelectMode = 1 {
					set tMe.custchannel = $s('$system.CLS.IsMthd("custchannelOdbcToLogical"):tImporter.%GetData(1),1:tMe.custchannelOdbcToLogical(tImporter.%GetData(1)))
					set tMe.roomprice = $s('$system.CLS.IsMthd("roompriceOdbcToLogical"):tImporter.%GetData(2),1:tMe.roompriceOdbcToLogical(tImporter.%GetData(2)))
				}
				elseif pSelectMode = 2 {
					set tMe.custchannel = $s('$system.CLS.IsMthd("custchannelDisplayToLogical"):tImporter.%GetData(1),1:tMe.custchannelDisplayToLogical(tImporter.%GetData(1)))
					set tMe.roomprice = $s('$system.CLS.IsMthd("roompriceDisplayToLogical"):tImporter.%GetData(2),1:tMe.roompriceDisplayToLogical(tImporter.%GetData(2)))
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

Parameter ROWTYPE = "cust_channel VARCHAR(250),room_price INTEGER";

Storage Default
{
<Data name="NumPriceChannelDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>custchannel</Value>
</Value>
<Value name="3">
<Value>roomprice</Value>
</Value>
</Data>
<DataLocation>^Data.NumPriceChannelD</DataLocation>
<DefaultData>NumPriceChannelDefaultData</DefaultData>
<IdLocation>^Data.NumPriceChannelD</IdLocation>
<IndexLocation>^Data.NumPriceChannelI</IndexLocation>
<StreamLocation>^Data.NumPriceChannelS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
