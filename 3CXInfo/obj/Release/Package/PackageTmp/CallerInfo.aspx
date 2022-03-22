<%@ Page Title="Caller - Infomatioon" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CallerInfo.aspx.cs" Inherits="_3CXInfo.CallerInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dataTables_filter {
            float: right;
            text-align: right;
        }
    </style>

    <script type="text/javascript">
        function searchData() {
            var NumberPhone_;
            var dateStart_;
            var dateEnd_;

            //NumberPhone
            if ($('#txtNumberPhone').val()) {
                NumberPhone_ = $('#txtNumberPhone').val().toString();
            }
            else {
                return alert('ระบุหมายเลขโทรศัพท์');
            }
            //dateStart
            if ($('#txtDateStart').val()) {
                dateStart_ = $('#txtDateStart').val().toString();
            }
            else {
                return alert('ระบุวันที่เริ่มต้น');
            }
            //dateEnd
            if ($('#txtDateEnd').val()) {
                dateEnd_ = $('#txtDateEnd').val().toString();
            }
            else {
                return alert('ระบุวันที่สิ้นสุด');
            }

            var data_ = '{numberPhone: "' + NumberPhone_ + '", dateStart: "' + dateStart_ + '", dateEnd: "' + dateEnd_ + '", type: true}';
            console.log(data_);

            getCallerInfo(data_);

        }

        function getCallerInfo(data_) {
            $.ajax({
                url: 'CallerInfo.aspx/getCallerInfo',
                type: 'POST',
                data: data_,
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    if (response) {

                        var json_d = response.d;
                        //console.log(json_d);

                        // convert string to JSON
                        json_d = $.parseJSON(json_d);
                        console.log(json_d);

                        drawTable(json_d);

                    }//end if
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        function drawTable(data) {
            var rows = [];
            for (var i = 0; i < data.length; i++) {
                //rows.push($("<td>" + i + "</td>"));

                rows.push(drawRow(data[i], i));
            }

            $('#thisDataTable').DataTable().clear().draw();
            $('#thisDataTable').dataTable().fnDestroy();

            $('#thisDataTable').append(rows);

            $('#thisDataTable').DataTable({
                //destroy: true,
                language: {
                    emptyTable: "ไม่พบข้อมูล"
                },
                searching: true,
                paging: true,
                //pageLength: 10,
                //pagingType: "simple_numbers"
            });
        }

        function drawRow(rowData, i) {
            var row = $("<tr />")
            row.append($("<td>" + (i + 1) + "</td>"));
            row.append($("<td>" + rowData.from_dn + "</td>"));
            row.append($("<td>" + rowData.from_dispname + "</td>"));
            row.append($("<td>" + rowData.to_dn + "</td>"));
            row.append($("<td>" + rowData.duration + "</td>"));
            row.append($("<td>" + rowData.time_start + "</td>"));
            row.append($("<td>" + rowData.time_end + "</td>"));
            if (rowData.to_type === 'VMail') {
                row.append($("<td><span style='width: 110px;'><span class='label font-weight-bold label-lg label-light-danger label-inline'>VoiceMail</span></span></td>"));
                return row;
            }
            else {
                row.append($("<td></td>"));
                return row;
            }

            //row.append($("<td id='td_vmail'>VoiceMail</td>"));

            //console.log(rowData);
            return row;
        }

        function loadTODAY() {
            var data_ = '{numberPhone: null, dateStart: null, dateEnd: null, type: false}';
            console.log(data_);

            getCallerInfo(data_);
        }

        function clearFilter() {
            //NumberPhone
            $('#txtNumberPhone').val('');
            $('#txtDateStart').val('');
            $('#txtDateEnd').val('');

        }

        function lgTimeout() {
            //alert('ล็อคอินหมดอายุ กรุณาทำการล็อคอินใหม่อีกครั้ง');
            sessionStorage.clear();
            return window.location.replace("./Login.aspx");
        }

        function fnLogOut() {
            sessionStorage.clear();
            return window.location.replace("./Login.aspx");
        }

        jQuery(document).ready(function () {

            var x = sessionStorage["lgn"];
            if (x === "s") {
                const myTimeout = setTimeout(lgTimeout, 360000);//milliseconds
                loadTODAY();
            }
            else {
                return window.location.replace("./Login.aspx");
            }

            //กรอกข้อมูลเฉพาะตัวเลข
            $('#txtNumberPhone').keypress(function (e) {
                var charCode = (e.which) ? e.which : e.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    return false;
                }
            });

        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="d-flex align-items-center justify-content-between flex-wrap flex-sm-nowrap">
        <div style="display: flex; justify-content: flex-end">
            <div>&nbsp;</div>
        </div>
        <%--<a href="#" class="btn btn-hover-bg-danger btn-text-danger btn-hover-text-white border-0 font-weight-bold mr-2">Danger</a>--%>
        <input id="btnLogOut" type="button" value="ออกจากระบบ" class="btn btn-hover-bg-danger btn-text-danger btn-hover-text-white border-0 font-weight-bold mr-2" onclick="fnLogOut()" />

    </div>
    <div class="d-flex flex-column flex-row-fluid wrapper" id="kt_wrapper" style="margin-top: 5px;">
        <!--begin::Content-->

        <!--begin::Subheader-->
        <div class="subheader py-2 py-lg-6 subheader-transparent" id="kt_subheader">
            <div class="container d-flex align-items-center justify-content-between flex-wrap flex-sm-nowrap">
                <div class="flex-wrap border-0 pt-6 pb-0">


                    <div class="row">
                        <div class="col-xl-4">
                            <div class="form-group">
                                <label class="form-control-label">หมายเลขโทรศัพท์ปลายทาง<span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input id="txtNumberPhone" placeholder="หมายเลขโทรศัพท์" autocomplete="off" class="form-control" />
                                    <div class="input-group-append"><span class="input-group-text"><i class="la la-phone"></i></span></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3">
                            <div class="form-group">
                                <label class="form-control-label">วันที่เริ่มต้น<span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input id="txtDateStart" type="text" placeholder="วันที่เริ่มต้น" autocomplete="off" class="form-control datepicker" />
                                    <div class="input-group-append"><span class="input-group-text"><i class="la la-calendar-week"></i></span></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3">
                            <div class="form-group">
                                <label class="form-control-label">วันที่สิ้นสุด<span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input id="txtDateEnd" type="text" placeholder="วันที่สิ้นสุด" autocomplete="off" class="form-control datepicker" />
                                    <div class="input-group-append"><span class="input-group-text"><i class="la la-calendar-week"></i></span></div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-1">
                            <div class="form-group">
                                <label class="form-control-label">&nbsp;</label>
                                <input id="btnSearch" type="button" value="ค้นหา" class="btn btn-light-success font-weight-bold" onclick="searchData()" />

                            </div>
                        </div>
                        <div class="col-xl-1">
                            <div class="form-group">
                                <label class="form-control-label">&nbsp;</label>
                                <input id="btnClear" type="button" value="เริ่มใหม่" class="btn btn-light-warning font-weight-bold mr-2" onclick="clearFilter()" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--end::Subheader-->
        <!--begin::Entry-->
        <div class="d-flex flex-column-fluid">
            <!--begin::Container-->
            <div class="container-fluid">
                <!--begin::Card-->
                <div class="card card-custom">
                    <!--begin: Datatable-->
                    <div class="card card-custom">
                        <div class="card-header flex-wrap border-0 pt-6 pb-0">
                            <div class="card-title">
                                <h3 class="card-label">Caller Info
											<%--<span class="d-block text-muted pt-2 font-size-sm">light head and row separator</span>--%></h3>
                            </div>
                            <div class="card-toolbar">
                                <%--<button id="btnRefresh" title="รีเฟรช" class="btn btn-icon btn-light-warning btn-lg mr-4" onclick="loadTODAY()">
                                        <i class="flaticon2-rocket-1"></i>
                                    </button>--%>
                                <input id="btnRefresh" type="button" value="ดูวันนี้" class="btn btn-light-danger font-weight-bold" onclick="loadTODAY()" />
                                <!--begin::Button-->
                                <%--<a href="#" class="btn btn-light-primary font-weight-bolder">
                                        <i class="la la-plus"></i>New Record</a>--%>
                                <!--end::Button-->
                            </div>
                        </div>
                        <div class="card-body">
                            <table class="table table-hover table-head-custom dataTable" id="thisDataTable">
                                <thead>
                                    <tr>
                                        <th>ลำดับ</th>
                                        <th>หมายเลข IP-Phone</th>
                                        <th>ชื่อโครงการ</th>
                                        <th>หมายเลขปลายทาง</th>
                                        <th>ระยะเวลา</th>
                                        <th>วันที่เริ่มต้น</th>
                                        <th>วันที่สิ้นสุด</th>
                                        <th>&nbsp;</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>

                        </div>
                    </div>

                </div>
                <!--end::Card-->
            </div>
            <!--end::Container-->
        </div>
        <!--end::Entry-->
    </div>
    <!--end::Content-->



</asp:Content>
