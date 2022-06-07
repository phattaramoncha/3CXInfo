<%@ Page Title="Caller - Infomatioon" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CallerInfo.aspx.cs" Inherits="_3CXInfo.CallerInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dataTables_filter {
            float: right;
            text-align: right;
        }

        .header {
            padding: 10px;
            background: #37474f;
            color: white;
            font-size: 14px;
        }

        .navbar {
            background-color: #37474f;
            padding-bottom: 5px;
        }

            .navbar > .container-fluid {
                align-items: stretch;
                display: flex;
                min-height: 3.25rem;
                width: 100%;
            }
    </style>

    <script type="text/javascript">

        function getPRM(f) {
            var NumberPhone_;
            var dateStart_;
            var dateEnd_;

            if (f) {

                //NumberPhone
                if ($('#txtNumberPhone').val()) {
                    NumberPhone_ = $('#txtNumberPhone').val().toString();
                }
                else {
                    return alert('ระบุหมายเลขโทรศัพท์');
                }

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

            var data_ = '{numberPhone: "' + NumberPhone_ + '", dateStart: "' + dateStart_ + '", dateEnd: "' + dateEnd_ + '", type: true, toDN: ' + f + '}';

            return data_;
        }

        function searchData() {

            //console.log(data_);

            var prm_ = getPRM(true);

            getCallerInfo(prm_);

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
                        //console.log(json_d);

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
            clearFilter();
            var data_ = '{numberPhone: null, dateStart: null, dateEnd: null, type: false, toDN: false}';
            //console.log(data_);

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

        function exportReport() {
            var prm_ = getPRM(false);

            $.ajax({
                url: 'CallerInfo.aspx/ExportReport',
                type: 'POST',
                data: prm_,
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    if (response) {

                        var json_d = response.d;
                        //console.log(json_d);

                        // convert string to JSON
                        //json_d = $.parseJSON(json_d);
                        console.log(json_d);


                        //window.location = response;
                        //// OR
                        window.location = response.d;
                        //window.open(response.d, '_blank');


                    }//end if
                },
                failure: function (response) {
                    alert(response.d);
                }
            });
        }

        jQuery(document).ready(function () {

            var x = sessionStorage["lgn"];
            if (x === "s") {
                const myTimeout = setTimeout(lgTimeout, 3600000);//milliseconds
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


    <div class="navbar">
        <div class="container-fluid">
            <%--<a class="navbar-brand" href="#">
                <img src="/assets/logo-cm.png" width="45" height="30" alt="">
            </a>--%>


            <a class="navbar-brand">
                <%--<img src="assets/media/svg/icons/Communication/Address-card.svg" alt="" width="30" height="24" class="d-inline-block align-text-top">--%>
                <div>


                    <span class="svg-icon svg-icon-primary svg-icon-2x">
                        <!--begin::Svg Icon | path:C:\wamp64\www\keenthemes\themes\metronic\theme\html\demo6\dist/../src/media/svg/icons\Communication\Address-card.svg-->
                        <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                            <rect x="0" y="0" width="24" height="24" />
                            <path d="M6,2 L18,2 C19.6568542,2 21,3.34314575 21,5 L21,19 C21,20.6568542 19.6568542,22 18,22 L6,22 C4.34314575,22 3,20.6568542 3,19 L3,5 C3,3.34314575 4.34314575,2 6,2 Z M12,11 C13.1045695,11 14,10.1045695 14,9 C14,7.8954305 13.1045695,7 12,7 C10.8954305,7 10,7.8954305 10,9 C10,10.1045695 10.8954305,11 12,11 Z M7.00036205,16.4995035 C6.98863236,16.6619875 7.26484009,17 7.4041679,17 C11.463736,17 14.5228466,17 16.5815,17 C16.9988413,17 17.0053266,16.6221713 16.9988413,16.5 C16.8360465,13.4332455 14.6506758,12 11.9907452,12 C9.36772908,12 7.21569918,13.5165724 7.00036205,16.4995035 Z" fill="#000000" />
                        </g>
                        </svg>
                        Call Log 
                    </span>
                </div>
            </a>



            <a onclick="fnLogOut()" class="nav-link btn btn-icon btn-hover-text-primary btn-lg active" title="ออกจากระบบ">
                <span class="svg-icon svg-icon-xxl">
                    <!--begin::Svg Icon | path:assets/media/svg/icons/Communication/Group.svg-->
                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="24px" height="24px" viewBox="0 0 24 24" version="1.1">
                        <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                            <polygon points="0 0 24 0 24 24 0 24"></polygon>
                            <path d="M18,14 C16.3431458,14 15,12.6568542 15,11 C15,9.34314575 16.3431458,8 18,8 C19.6568542,8 21,9.34314575 21,11 C21,12.6568542 19.6568542,14 18,14 Z M9,11 C6.790861,11 5,9.209139 5,7 C5,4.790861 6.790861,3 9,3 C11.209139,3 13,4.790861 13,7 C13,9.209139 11.209139,11 9,11 Z" fill="#000000" fill-rule="nonzero" opacity="0.3"></path>
                            <path d="M17.6011961,15.0006174 C21.0077043,15.0378534 23.7891749,16.7601418 23.9984937,20.4 C24.0069246,20.5466056 23.9984937,21 23.4559499,21 L19.6,21 C19.6,18.7490654 18.8562935,16.6718327 17.6011961,15.0006174 Z M0.00065168429,20.1992055 C0.388258525,15.4265159 4.26191235,13 8.98334134,13 C13.7712164,13 17.7048837,15.2931929 17.9979143,20.2 C18.0095879,20.3954741 17.9979143,21 17.2466999,21 C13.541124,21 8.03472472,21 0.727502227,21 C0.476712155,21 -0.0204617505,20.45918 0.00065168429,20.1992055 Z" fill="#000000" fill-rule="nonzero"></path>
                        </g>
                    </svg>
                    <!--end::Svg Icon-->
                </span>
            </a>

        </div>

    </div>
    <div class="d-flex flex-column flex-row-fluid wrapper" id="kt_wrapper" style="margin-top: 5px; margin-bottom: 5px; margin-left: 40px;">
        <!--begin::Content-->

        <!--begin::Subheader-->
        <div class="subheader py-2 py-lg-6 subheader-transparent" id="kt_subheader">
            <div class="container d-flex align-items-center justify-content-between flex-wrap flex-sm-nowrap">
                <div class="flex-wrap border-0 pt-6 pb-0">

                    <div class="card card-custom">
                        <div class="card-body">

                            <div class="row">
                                <div class="col-xl-4">
                                    <div class="form-group">
                                        <label class="form-control-label">หมายเลขโทรศัพท์ปลายทาง<span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <input id="txtNumberPhone" placeholder="หมายเลขโทรศัพท์" autocomplete="off" class="form-control" />
                                            <div class="input-group-append">
                                                <span class="input-group-text">
                                                    <i class="la la-phone"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3">
                                    <div class="form-group">
                                        <label class="form-control-label">วันที่เริ่มต้น<span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <input id="txtDateStart" type="text" placeholder="วันที่เริ่มต้น" autocomplete="off" class="form-control datepicker" />
                                            <div class="input-group-append">
                                                <span class="input-group-text">
                                                    <i class="la la-calendar-week"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3">
                                    <div class="form-group">
                                        <label class="form-control-label">วันที่สิ้นสุด<span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <input id="txtDateEnd" type="text" placeholder="วันที่สิ้นสุด" autocomplete="off" class="form-control datepicker" />
                                            <div class="input-group-append">
                                                <span class="input-group-text">
                                                    <i class="la la-calendar-week"></i>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-1">
                                    <div class="form-group">
                                        <label class="form-control-label">&nbsp;</label>
                                        <input id="btnSearch" type="button" value="ค้นหา" class="btn btn-success font-weight-bold" onclick="searchData()" />

                                    </div>
                                </div>
                                <div class="col-xl-1">
                                    <div class="form-group">
                                        <label class="form-control-label">&nbsp;</label>
                                        <input id="btnClear" type="button" value="ล้างค่า" class="btn btn-light font-weight-bold mr-2" onclick="clearFilter()" />
                                    </div>
                                </div>
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
            <div class="container-fluid" style="margin-bottom: 40px;">
                <!--begin::Card-->
                <div class="card card-custom">
                    <!--begin: Datatable-->

                    <div class="card-header flex-wrap border-0 pt-6 pb-0">
                        <div class="card-title">
                            <h3 class="card-label">Caller Info
                                    <%--<span class="d-block text-muted pt-2 font-size-sm">light head and row separator</span>--%>
                            </h3>
                        </div>
                        <div class="card-toolbar">

                            <a id="btnReport" class="btn btn-outline-success font-weight-bold" onclick="exportReport()"><i class="flaticon2-poll-symbol"></i>ออกรายงาน</a>

                            <%--<input type="button" value="  ออกรายงาน" />--%>
                                &nbsp;&nbsp;
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
                <!--end::Card-->
            </div>
            <!--end::Container-->
        </div>
        <!--end::Entry-->
    </div>
    <!--end::Content-->
</asp:Content>
