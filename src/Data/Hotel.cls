Class Data.Hotel Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property hotel As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 2 ];

Property iscanceled As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 3, SqlFieldName = is_canceled ];

Property leadtime As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 4, SqlFieldName = lead_time ];

Property arrivaldateyear As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 5, SqlFieldName = arrival_date_year ];

Property arrivaldatemonth As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 6, SqlFieldName = arrival_date_month ];

Property arrivaldateweeknumber As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 7, SqlFieldName = arrival_date_week_number ];

Property arrivaldatedayofmonth As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 8, SqlFieldName = arrival_date_day_of_month ];

Property staysinweekendnights As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 9, SqlFieldName = stays_in_weekend_nights ];

Property staysinweeknights As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 10, SqlFieldName = stays_in_week_nights ];

Property adults As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 11 ];

Property children As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 12 ];

Property babies As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 13 ];

Property meal As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 14 ];

Property country As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 15 ];

Property marketsegment As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 16, SqlFieldName = market_segment ];

Property distributionchannel As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 17, SqlFieldName = distribution_channel ];

Property isrepeatedguest As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 18, SqlFieldName = is_repeated_guest ];

Property previouscancellations As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 19, SqlFieldName = previous_cancellations ];

Property previousbookingsnotcanceled As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 20, SqlFieldName = previous_bookings_not_canceled ];

Property reservedroomtype As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 21, SqlFieldName = reserved_room_type ];

Property assignedroomtype As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 22, SqlFieldName = assigned_room_type ];

Property bookingchanges As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 23, SqlFieldName = booking_changes ];

Property deposittype As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 24, SqlFieldName = deposit_type ];

Property agent As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 25 ];

Property company As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 26 ];

Property daysinwaitinglist As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 27, SqlFieldName = days_in_waiting_list ];

Property customertype As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 28, SqlFieldName = customer_type ];

Property adr As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 29 ];

Property requiredcarparkingspaces As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 30, SqlFieldName = required_car_parking_spaces ];

Property totalofspecialrequests As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 31, SqlFieldName = total_of_special_requests ];

Property reservationstatus As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 32, SqlFieldName = reservation_status ];

Property reservationstatusdate As %Library.Date [ SqlColumnNumber = 33, SqlFieldName = reservation_status_date ];

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
					set tMe.hotel = tImporter.%GetData(1)
					set tMe.iscanceled = tImporter.%GetData(2)
					set tMe.leadtime = tImporter.%GetData(3)
					set tMe.arrivaldateyear = tImporter.%GetData(4)
					set tMe.arrivaldatemonth = tImporter.%GetData(5)
					set tMe.arrivaldateweeknumber = tImporter.%GetData(6)
					set tMe.arrivaldatedayofmonth = tImporter.%GetData(7)
					set tMe.staysinweekendnights = tImporter.%GetData(8)
					set tMe.staysinweeknights = tImporter.%GetData(9)
					set tMe.adults = tImporter.%GetData(10)
					set tMe.children = tImporter.%GetData(11)
					set tMe.babies = tImporter.%GetData(12)
					set tMe.meal = tImporter.%GetData(13)
					set tMe.country = tImporter.%GetData(14)
					set tMe.marketsegment = tImporter.%GetData(15)
					set tMe.distributionchannel = tImporter.%GetData(16)
					set tMe.isrepeatedguest = tImporter.%GetData(17)
					set tMe.previouscancellations = tImporter.%GetData(18)
					set tMe.previousbookingsnotcanceled = tImporter.%GetData(19)
					set tMe.reservedroomtype = tImporter.%GetData(20)
					set tMe.assignedroomtype = tImporter.%GetData(21)
					set tMe.bookingchanges = tImporter.%GetData(22)
					set tMe.deposittype = tImporter.%GetData(23)
					set tMe.agent = tImporter.%GetData(24)
					set tMe.company = tImporter.%GetData(25)
					set tMe.daysinwaitinglist = tImporter.%GetData(26)
					set tMe.customertype = tImporter.%GetData(27)
					set tMe.adr = tImporter.%GetData(28)
					set tMe.requiredcarparkingspaces = tImporter.%GetData(29)
					set tMe.totalofspecialrequests = tImporter.%GetData(30)
					set tMe.reservationstatus = tImporter.%GetData(31)
					set tMe.reservationstatusdate = tImporter.%GetData(32)
				}
				elseif pSelectMode = 1 {
					set tMe.hotel = $s('$system.CLS.IsMthd("hotelOdbcToLogical"):tImporter.%GetData(1),1:tMe.hotelOdbcToLogical(tImporter.%GetData(1)))
					set tMe.iscanceled = $s('$system.CLS.IsMthd("iscanceledOdbcToLogical"):tImporter.%GetData(2),1:tMe.iscanceledOdbcToLogical(tImporter.%GetData(2)))
					set tMe.leadtime = $s('$system.CLS.IsMthd("leadtimeOdbcToLogical"):tImporter.%GetData(3),1:tMe.leadtimeOdbcToLogical(tImporter.%GetData(3)))
					set tMe.arrivaldateyear = $s('$system.CLS.IsMthd("arrivaldateyearOdbcToLogical"):tImporter.%GetData(4),1:tMe.arrivaldateyearOdbcToLogical(tImporter.%GetData(4)))
					set tMe.arrivaldatemonth = $s('$system.CLS.IsMthd("arrivaldatemonthOdbcToLogical"):tImporter.%GetData(5),1:tMe.arrivaldatemonthOdbcToLogical(tImporter.%GetData(5)))
					set tMe.arrivaldateweeknumber = $s('$system.CLS.IsMthd("arrivaldateweeknumberOdbcToLogical"):tImporter.%GetData(6),1:tMe.arrivaldateweeknumberOdbcToLogical(tImporter.%GetData(6)))
					set tMe.arrivaldatedayofmonth = $s('$system.CLS.IsMthd("arrivaldatedayofmonthOdbcToLogical"):tImporter.%GetData(7),1:tMe.arrivaldatedayofmonthOdbcToLogical(tImporter.%GetData(7)))
					set tMe.staysinweekendnights = $s('$system.CLS.IsMthd("staysinweekendnightsOdbcToLogical"):tImporter.%GetData(8),1:tMe.staysinweekendnightsOdbcToLogical(tImporter.%GetData(8)))
					set tMe.staysinweeknights = $s('$system.CLS.IsMthd("staysinweeknightsOdbcToLogical"):tImporter.%GetData(9),1:tMe.staysinweeknightsOdbcToLogical(tImporter.%GetData(9)))
					set tMe.adults = $s('$system.CLS.IsMthd("adultsOdbcToLogical"):tImporter.%GetData(10),1:tMe.adultsOdbcToLogical(tImporter.%GetData(10)))
					set tMe.children = $s('$system.CLS.IsMthd("childrenOdbcToLogical"):tImporter.%GetData(11),1:tMe.childrenOdbcToLogical(tImporter.%GetData(11)))
					set tMe.babies = $s('$system.CLS.IsMthd("babiesOdbcToLogical"):tImporter.%GetData(12),1:tMe.babiesOdbcToLogical(tImporter.%GetData(12)))
					set tMe.meal = $s('$system.CLS.IsMthd("mealOdbcToLogical"):tImporter.%GetData(13),1:tMe.mealOdbcToLogical(tImporter.%GetData(13)))
					set tMe.country = $s('$system.CLS.IsMthd("countryOdbcToLogical"):tImporter.%GetData(14),1:tMe.countryOdbcToLogical(tImporter.%GetData(14)))
					set tMe.marketsegment = $s('$system.CLS.IsMthd("marketsegmentOdbcToLogical"):tImporter.%GetData(15),1:tMe.marketsegmentOdbcToLogical(tImporter.%GetData(15)))
					set tMe.distributionchannel = $s('$system.CLS.IsMthd("distributionchannelOdbcToLogical"):tImporter.%GetData(16),1:tMe.distributionchannelOdbcToLogical(tImporter.%GetData(16)))
					set tMe.isrepeatedguest = $s('$system.CLS.IsMthd("isrepeatedguestOdbcToLogical"):tImporter.%GetData(17),1:tMe.isrepeatedguestOdbcToLogical(tImporter.%GetData(17)))
					set tMe.previouscancellations = $s('$system.CLS.IsMthd("previouscancellationsOdbcToLogical"):tImporter.%GetData(18),1:tMe.previouscancellationsOdbcToLogical(tImporter.%GetData(18)))
					set tMe.previousbookingsnotcanceled = $s('$system.CLS.IsMthd("previousbookingsnotcanceledOdbcToLogical"):tImporter.%GetData(19),1:tMe.previousbookingsnotcanceledOdbcToLogical(tImporter.%GetData(19)))
					set tMe.reservedroomtype = $s('$system.CLS.IsMthd("reservedroomtypeOdbcToLogical"):tImporter.%GetData(20),1:tMe.reservedroomtypeOdbcToLogical(tImporter.%GetData(20)))
					set tMe.assignedroomtype = $s('$system.CLS.IsMthd("assignedroomtypeOdbcToLogical"):tImporter.%GetData(21),1:tMe.assignedroomtypeOdbcToLogical(tImporter.%GetData(21)))
					set tMe.bookingchanges = $s('$system.CLS.IsMthd("bookingchangesOdbcToLogical"):tImporter.%GetData(22),1:tMe.bookingchangesOdbcToLogical(tImporter.%GetData(22)))
					set tMe.deposittype = $s('$system.CLS.IsMthd("deposittypeOdbcToLogical"):tImporter.%GetData(23),1:tMe.deposittypeOdbcToLogical(tImporter.%GetData(23)))
					set tMe.agent = $s('$system.CLS.IsMthd("agentOdbcToLogical"):tImporter.%GetData(24),1:tMe.agentOdbcToLogical(tImporter.%GetData(24)))
					set tMe.company = $s('$system.CLS.IsMthd("companyOdbcToLogical"):tImporter.%GetData(25),1:tMe.companyOdbcToLogical(tImporter.%GetData(25)))
					set tMe.daysinwaitinglist = $s('$system.CLS.IsMthd("daysinwaitinglistOdbcToLogical"):tImporter.%GetData(26),1:tMe.daysinwaitinglistOdbcToLogical(tImporter.%GetData(26)))
					set tMe.customertype = $s('$system.CLS.IsMthd("customertypeOdbcToLogical"):tImporter.%GetData(27),1:tMe.customertypeOdbcToLogical(tImporter.%GetData(27)))
					set tMe.adr = $s('$system.CLS.IsMthd("adrOdbcToLogical"):tImporter.%GetData(28),1:tMe.adrOdbcToLogical(tImporter.%GetData(28)))
					set tMe.requiredcarparkingspaces = $s('$system.CLS.IsMthd("requiredcarparkingspacesOdbcToLogical"):tImporter.%GetData(29),1:tMe.requiredcarparkingspacesOdbcToLogical(tImporter.%GetData(29)))
					set tMe.totalofspecialrequests = $s('$system.CLS.IsMthd("totalofspecialrequestsOdbcToLogical"):tImporter.%GetData(30),1:tMe.totalofspecialrequestsOdbcToLogical(tImporter.%GetData(30)))
					set tMe.reservationstatus = $s('$system.CLS.IsMthd("reservationstatusOdbcToLogical"):tImporter.%GetData(31),1:tMe.reservationstatusOdbcToLogical(tImporter.%GetData(31)))
					set tMe.reservationstatusdate = $s('$system.CLS.IsMthd("reservationstatusdateOdbcToLogical"):tImporter.%GetData(32),1:tMe.reservationstatusdateOdbcToLogical(tImporter.%GetData(32)))
				}
				elseif pSelectMode = 2 {
					set tMe.hotel = $s('$system.CLS.IsMthd("hotelDisplayToLogical"):tImporter.%GetData(1),1:tMe.hotelDisplayToLogical(tImporter.%GetData(1)))
					set tMe.iscanceled = $s('$system.CLS.IsMthd("iscanceledDisplayToLogical"):tImporter.%GetData(2),1:tMe.iscanceledDisplayToLogical(tImporter.%GetData(2)))
					set tMe.leadtime = $s('$system.CLS.IsMthd("leadtimeDisplayToLogical"):tImporter.%GetData(3),1:tMe.leadtimeDisplayToLogical(tImporter.%GetData(3)))
					set tMe.arrivaldateyear = $s('$system.CLS.IsMthd("arrivaldateyearDisplayToLogical"):tImporter.%GetData(4),1:tMe.arrivaldateyearDisplayToLogical(tImporter.%GetData(4)))
					set tMe.arrivaldatemonth = $s('$system.CLS.IsMthd("arrivaldatemonthDisplayToLogical"):tImporter.%GetData(5),1:tMe.arrivaldatemonthDisplayToLogical(tImporter.%GetData(5)))
					set tMe.arrivaldateweeknumber = $s('$system.CLS.IsMthd("arrivaldateweeknumberDisplayToLogical"):tImporter.%GetData(6),1:tMe.arrivaldateweeknumberDisplayToLogical(tImporter.%GetData(6)))
					set tMe.arrivaldatedayofmonth = $s('$system.CLS.IsMthd("arrivaldatedayofmonthDisplayToLogical"):tImporter.%GetData(7),1:tMe.arrivaldatedayofmonthDisplayToLogical(tImporter.%GetData(7)))
					set tMe.staysinweekendnights = $s('$system.CLS.IsMthd("staysinweekendnightsDisplayToLogical"):tImporter.%GetData(8),1:tMe.staysinweekendnightsDisplayToLogical(tImporter.%GetData(8)))
					set tMe.staysinweeknights = $s('$system.CLS.IsMthd("staysinweeknightsDisplayToLogical"):tImporter.%GetData(9),1:tMe.staysinweeknightsDisplayToLogical(tImporter.%GetData(9)))
					set tMe.adults = $s('$system.CLS.IsMthd("adultsDisplayToLogical"):tImporter.%GetData(10),1:tMe.adultsDisplayToLogical(tImporter.%GetData(10)))
					set tMe.children = $s('$system.CLS.IsMthd("childrenDisplayToLogical"):tImporter.%GetData(11),1:tMe.childrenDisplayToLogical(tImporter.%GetData(11)))
					set tMe.babies = $s('$system.CLS.IsMthd("babiesDisplayToLogical"):tImporter.%GetData(12),1:tMe.babiesDisplayToLogical(tImporter.%GetData(12)))
					set tMe.meal = $s('$system.CLS.IsMthd("mealDisplayToLogical"):tImporter.%GetData(13),1:tMe.mealDisplayToLogical(tImporter.%GetData(13)))
					set tMe.country = $s('$system.CLS.IsMthd("countryDisplayToLogical"):tImporter.%GetData(14),1:tMe.countryDisplayToLogical(tImporter.%GetData(14)))
					set tMe.marketsegment = $s('$system.CLS.IsMthd("marketsegmentDisplayToLogical"):tImporter.%GetData(15),1:tMe.marketsegmentDisplayToLogical(tImporter.%GetData(15)))
					set tMe.distributionchannel = $s('$system.CLS.IsMthd("distributionchannelDisplayToLogical"):tImporter.%GetData(16),1:tMe.distributionchannelDisplayToLogical(tImporter.%GetData(16)))
					set tMe.isrepeatedguest = $s('$system.CLS.IsMthd("isrepeatedguestDisplayToLogical"):tImporter.%GetData(17),1:tMe.isrepeatedguestDisplayToLogical(tImporter.%GetData(17)))
					set tMe.previouscancellations = $s('$system.CLS.IsMthd("previouscancellationsDisplayToLogical"):tImporter.%GetData(18),1:tMe.previouscancellationsDisplayToLogical(tImporter.%GetData(18)))
					set tMe.previousbookingsnotcanceled = $s('$system.CLS.IsMthd("previousbookingsnotcanceledDisplayToLogical"):tImporter.%GetData(19),1:tMe.previousbookingsnotcanceledDisplayToLogical(tImporter.%GetData(19)))
					set tMe.reservedroomtype = $s('$system.CLS.IsMthd("reservedroomtypeDisplayToLogical"):tImporter.%GetData(20),1:tMe.reservedroomtypeDisplayToLogical(tImporter.%GetData(20)))
					set tMe.assignedroomtype = $s('$system.CLS.IsMthd("assignedroomtypeDisplayToLogical"):tImporter.%GetData(21),1:tMe.assignedroomtypeDisplayToLogical(tImporter.%GetData(21)))
					set tMe.bookingchanges = $s('$system.CLS.IsMthd("bookingchangesDisplayToLogical"):tImporter.%GetData(22),1:tMe.bookingchangesDisplayToLogical(tImporter.%GetData(22)))
					set tMe.deposittype = $s('$system.CLS.IsMthd("deposittypeDisplayToLogical"):tImporter.%GetData(23),1:tMe.deposittypeDisplayToLogical(tImporter.%GetData(23)))
					set tMe.agent = $s('$system.CLS.IsMthd("agentDisplayToLogical"):tImporter.%GetData(24),1:tMe.agentDisplayToLogical(tImporter.%GetData(24)))
					set tMe.company = $s('$system.CLS.IsMthd("companyDisplayToLogical"):tImporter.%GetData(25),1:tMe.companyDisplayToLogical(tImporter.%GetData(25)))
					set tMe.daysinwaitinglist = $s('$system.CLS.IsMthd("daysinwaitinglistDisplayToLogical"):tImporter.%GetData(26),1:tMe.daysinwaitinglistDisplayToLogical(tImporter.%GetData(26)))
					set tMe.customertype = $s('$system.CLS.IsMthd("customertypeDisplayToLogical"):tImporter.%GetData(27),1:tMe.customertypeDisplayToLogical(tImporter.%GetData(27)))
					set tMe.adr = $s('$system.CLS.IsMthd("adrDisplayToLogical"):tImporter.%GetData(28),1:tMe.adrDisplayToLogical(tImporter.%GetData(28)))
					set tMe.requiredcarparkingspaces = $s('$system.CLS.IsMthd("requiredcarparkingspacesDisplayToLogical"):tImporter.%GetData(29),1:tMe.requiredcarparkingspacesDisplayToLogical(tImporter.%GetData(29)))
					set tMe.totalofspecialrequests = $s('$system.CLS.IsMthd("totalofspecialrequestsDisplayToLogical"):tImporter.%GetData(30),1:tMe.totalofspecialrequestsDisplayToLogical(tImporter.%GetData(30)))
					set tMe.reservationstatus = $s('$system.CLS.IsMthd("reservationstatusDisplayToLogical"):tImporter.%GetData(31),1:tMe.reservationstatusDisplayToLogical(tImporter.%GetData(31)))
					set tMe.reservationstatusdate = $s('$system.CLS.IsMthd("reservationstatusdateDisplayToLogical"):tImporter.%GetData(32),1:tMe.reservationstatusdateDisplayToLogical(tImporter.%GetData(32)))
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

Parameter ROWTYPE = "hotel VARCHAR(250),is_canceled INTEGER,lead_time INTEGER,arrival_date_year INTEGER,arrival_date_month VARCHAR(250),arrival_date_week_number INTEGER,arrival_date_day_of_month INTEGER,stays_in_weekend_nights INTEGER,stays_in_week_nights INTEGER,adults INTEGER,children INTEGER,babies INTEGER,meal VARCHAR(250),country VARCHAR(250),market_segment VARCHAR(250),distribution_channel VARCHAR(250),is_repeated_guest INTEGER,previous_cancellations INTEGER,previous_bookings_not_canceled INTEGER,reserved_room_type VARCHAR(250),assigned_room_type VARCHAR(250),booking_changes INTEGER,deposit_type VARCHAR(250),agent VARCHAR(250),company VARCHAR(250),days_in_waiting_list INTEGER,customer_type VARCHAR(250),adr INTEGER,required_car_parking_spaces INTEGER,total_of_special_requests INTEGER,reservation_status VARCHAR(250),reservation_status_date DATE";

Storage Default
{
<Data name="HotelDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>hotel</Value>
</Value>
<Value name="3">
<Value>iscanceled</Value>
</Value>
<Value name="4">
<Value>leadtime</Value>
</Value>
<Value name="5">
<Value>arrivaldateyear</Value>
</Value>
<Value name="6">
<Value>arrivaldatemonth</Value>
</Value>
<Value name="7">
<Value>arrivaldateweeknumber</Value>
</Value>
<Value name="8">
<Value>arrivaldatedayofmonth</Value>
</Value>
<Value name="9">
<Value>staysinweekendnights</Value>
</Value>
<Value name="10">
<Value>staysinweeknights</Value>
</Value>
<Value name="11">
<Value>adults</Value>
</Value>
<Value name="12">
<Value>children</Value>
</Value>
<Value name="13">
<Value>babies</Value>
</Value>
<Value name="14">
<Value>meal</Value>
</Value>
<Value name="15">
<Value>country</Value>
</Value>
<Value name="16">
<Value>marketsegment</Value>
</Value>
<Value name="17">
<Value>distributionchannel</Value>
</Value>
<Value name="18">
<Value>isrepeatedguest</Value>
</Value>
<Value name="19">
<Value>previouscancellations</Value>
</Value>
<Value name="20">
<Value>previousbookingsnotcanceled</Value>
</Value>
<Value name="21">
<Value>reservedroomtype</Value>
</Value>
<Value name="22">
<Value>assignedroomtype</Value>
</Value>
<Value name="23">
<Value>bookingchanges</Value>
</Value>
<Value name="24">
<Value>deposittype</Value>
</Value>
<Value name="25">
<Value>agent</Value>
</Value>
<Value name="26">
<Value>company</Value>
</Value>
<Value name="27">
<Value>daysinwaitinglist</Value>
</Value>
<Value name="28">
<Value>customertype</Value>
</Value>
<Value name="29">
<Value>adr</Value>
</Value>
<Value name="30">
<Value>requiredcarparkingspaces</Value>
</Value>
<Value name="31">
<Value>totalofspecialrequests</Value>
</Value>
<Value name="32">
<Value>reservationstatus</Value>
</Value>
<Value name="33">
<Value>reservationstatusdate</Value>
</Value>
</Data>
<DataLocation>^Data.HotelD</DataLocation>
<DefaultData>HotelDefaultData</DefaultData>
<IdLocation>^Data.HotelD</IdLocation>
<IndexLocation>^Data.HotelI</IndexLocation>
<StreamLocation>^Data.HotelS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
