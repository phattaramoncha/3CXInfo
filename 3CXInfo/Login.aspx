<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="_3CXInfo.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8" />
    <title>Call Log</title>
    <meta name="description" content="Login page example" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <link rel="canonical" href="https://keenthemes.com/metronic" />
    <!--begin::Fonts-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" />
    <!--end::Fonts-->
    <!--begin::Page Custom Styles(used by this page)-->
    <link href="assets/css/pages/login/classic/login-4.css" rel="stylesheet" type="text/css" />
    <!--end::Page Custom Styles-->
    <!--begin::Global Theme Styles(used by all pages)-->
    <link href="assets/plugins/global/plugins.bundle.css" rel="stylesheet" type="text/css" />
    <link href="assets/plugins/custom/prismjs/prismjs.bundle.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/style.bundle.css" rel="stylesheet" type="text/css" />
    <!--end::Global Theme Styles-->
    <script src="assets/js/jquery-3.6.0.min.js"></script>

    <script type="text/javascript">
        function getLogin() {
            var usn_ = $('#txtUserName').val();
            var psw_ = $('#txtPassword').val();

            if (!usn_) {
                //$('#txtUserName').removeClass("form-control h-auto form-control-solid py-4 px-8").addClass("form-control h-auto form-control-solid py-4 px-8 is-invalid");
                return alert('กรอก UserName');
            }
            if (!psw_) {
                return alert('กรอก Password');
            }

            var data_ = '{usn: "' + usn_ + '", psw: "' + psw_ + '"}';
            //console.log(data_);

            AuthLogin(data_);
        }

        function AuthLogin(data_) {
            $.ajax({
                url: 'Login.aspx/AuthLogin',
                type: 'POST',
                data: data_,
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    if (response) {
                        var json_d = response.d;
                        //console.log(json_d);

                        var ps_json = JSON.parse(json_d);
                        //console.log(ps_json);

                        //NoPermission                       
                        if (ps_json === "The user name or password is incorrect.") {
                            var html_ = '<div class="alert alert-custom alert-light-danger  fade show mb-5" role = "alert" >' +
                                '<div class="alert-icon"><i class="flaticon-warning"></i></div>' +
                                '<div class="alert-text">ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง!</div>' +
                                '</div>';
                            return $('#dvNoPermission').html(html_);
                        }
                        //success
                        if (ps_json === "Success") {
                            console.log('Success');
                            $('#dvNoPermission').html('');

                            // similar behavior as an HTTP redirect
                            //window.location.replace("http://stackoverflow.com");

                            // similar behavior as clicking on a link
                            //window.location.href = "http://stackoverflow.com";
                            //localStorage['lgn'] = "s";
                            sessionStorage.setItem("lgn", "s");
                            //sessionStorage.setItem("lgn", "s");

                            return window.location.replace("./CallerInfo.aspx");
                        }
                    }
                }
            });
        }

        jQuery(document).ready(function () {
            $("#form1").on("submit", function (e) {
                //alert("Handler for .submit() called.");
                e.preventDefault();
                getLogin();
            });
        });
    </script>


    <style>
        body {
            background-image: url('assets/media/bg/bg-3.jpg');
        }
    </style>

</head>
<!--begin::Body-->
<body id="kt_body" class="header-fixed header-mobile-fixed subheader-enabled sidebar-enabled page-loading">
    <form id="form1" runat="server">
        <!--begin::Main-->
        <div class="d-flex flex-column flex-root">
            <!--begin::Login-->
            <div class="login login-4 login-signin-on d-flex flex-row-fluid" id="kt_login">
                <div class="d-flex flex-center flex-row-fluid bgi-size-cover bgi-position-top bgi-no-repeat" ><%--style="background-image: url('assets/media/bg/bg-3.jpg');"--%>
                    <div class="login-form text-center p-7 position-relative overflow-hidden">
                        <!--begin::Login Header-->
                        <div class="d-flex flex-center mb-15">
                            <%--<a href="#">
                                <img src="assets/media/logos/logo-letter-13.png" class="max-h-75px" alt="" />
                            </a>--%>
                        </div>
                        <!--end::Login Header-->
                        <!--begin::Login Sign in form-->
                        <div class="login-signin">
                            <div class="mb-20">
                                <h3>เข้าสู่ระบบ</h3>
                                <div class="text-muted font-weight-bold">กรอกข้อมูลของคุณเพื่อเข้าสู่ระบบ:</div>
                            </div>
                            <div class="form" id="kt_login_signin_form">
                                <div class="form-group mb-5">
                                    <input id="txtUserName" class="form-control h-auto form-control-solid py-4 px-8" type="text" placeholder="Username" name="username" autocomplete="off" />
                                </div>
                                <div class="form-group mb-5">
                                    <input id="txtPassword" class="form-control h-auto form-control-solid py-4 px-8" type="password" placeholder="Password" name="password" />
                                </div>

                                <input id="btnLogin" type="submit" class="btn btn-primary font-weight-bold px-9 py-4 my-3 mx-4" value="เข้าสู่ระบบ" /><%--onclick="getLogin()"--%>
                            </div>
                            <div id="dvNoPermission"></div>
                        </div>
                        <!--end::Login Sign in form-->

                    </div>
                </div>
            </div>
            <!--end::Login-->
        </div>
        <!--end::Main-->
    </form>
    <script>var HOST_URL = "https://preview.keenthemes.com/metronic/theme/html/tools/preview";</script>
    <!--begin::Global Config(global config for global JS scripts)-->
    <script>var KTAppSettings = { "breakpoints": { "sm": 576, "md": 768, "lg": 992, "xl": 1200, "xxl": 1200 }, "colors": { "theme": { "base": { "white": "#ffffff", "primary": "#8950FC", "secondary": "#E5EAEE", "success": "#1BC5BD", "info": "#8950FC", "warning": "#FFA800", "danger": "#F64E60", "light": "#F3F6F9", "dark": "#212121" }, "light": { "white": "#ffffff", "primary": "#E1E9FF", "secondary": "#ECF0F3", "success": "#C9F7F5", "info": "#EEE5FF", "warning": "#FFF4DE", "danger": "#FFE2E5", "light": "#F3F6F9", "dark": "#D6D6E0" }, "inverse": { "white": "#ffffff", "primary": "#ffffff", "secondary": "#212121", "success": "#ffffff", "info": "#ffffff", "warning": "#ffffff", "danger": "#ffffff", "light": "#464E5F", "dark": "#ffffff" } }, "gray": { "gray-100": "#F3F6F9", "gray-200": "#ECF0F3", "gray-300": "#E5EAEE", "gray-400": "#D6D6E0", "gray-500": "#B5B5C3", "gray-600": "#80808F", "gray-700": "#464E5F", "gray-800": "#1B283F", "gray-900": "#212121" } }, "font-family": "Poppins" };</script>
    <!--end::Global Config-->
    <!--begin::Global Theme Bundle(used by all pages)-->
    <script src="assets/plugins/global/plugins.bundle.js"></script>
    <script src="assets/plugins/custom/prismjs/prismjs.bundle.js"></script>
    <script src="assets/js/scripts.bundle.js"></script>
    <!--end::Global Theme Bundle-->
    <!--begin::Page Scripts(used by this page)-->
    <script src="assets/js/pages/custom/login/login-general.js"></script>
    <!--end::Page Scripts-->
</body>
<!--end::Body-->
</html>
