<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/web/MasterPageTopMenu.master" CodeFile="idp_by_unit.aspx.cs" Inherits="web_idp_by_unit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <link rel="stylesheet" type="text/css" href="../app-assets/fonts/simple-line-icons/style.min.css">

    <link href="apexcharts/dist/apexcharts.css" rel="stylesheet" />
    <script src="apexcharts/dist/apexcharts.js"></script>
    <script src="JS/PerfectScrollBar.js"></script>
    <style>
        .apexcharts-tooltip {
            background: #f3f3f3;
        }

        .apexcharts-title-text {
            font-weight: 600
        }

        .div-bg1-print-1730 {
            background-color: lightgray;
            padding: 1px 1px 1px 1px;
        }

        .div-bg2-print-1730 {
            background-color: white;
        }

        h6 {
            margin-bottom: 0px;
            font-size: 0.9rem;
        }

        .border_print {
            /*// border:1px solid #d3d3d3;*/
            /* border-bottom:1px;
           border-top:1px;
           border-left:1px;
           border-right:1px;
           border-color:lightcyan;*/
            border: 1px solid lightgray;
        }

        .border_black {
            /*// border:1px solid #d3d3d3;*/
            /* border-bottom:1px;
           border-top:1px;
           border-left:1px;
           border-right:1px;
           border-color:lightcyan;*/
            border: 3px solid black;
        }

        .card_mp_t {
            margin-top: 5px;
            margin-left: 5px;
            margin-right: 5px;
            padding-top: 5px;
            padding-left: 5px;
            padding-right: 5px;
        }

        .card_mp_b {
            margin-bottom: 5px;
            margin-left: 15px;
            margin-right: 15px;
            padding-bottom: 5px;
            padding-left: 15px;
            padding-right: 15px;
        }

        .hover_h:hover {
            color: #E0E0E0;
            font-size: 102%;
        }

        .lr_border {
            border-radius: 30%;
        }

        h6 {
            font-size: 0.9rem;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <a id="btnToTop" data-toggle="tooltip" data-placement="top" title="" data-original-title="Go to top"></a>

    <div id="divPage" class="app-content content canvas_div_pdf" data-ng-app="app" data-ng-controller="ctrlApp">

        <div class="content-wrapper">

            <div class="content-header">
                <div class="row">
                    <div class="col-xl-6 col-lg-6 col-md-12 col-12">
                        <h4 class="content-header-title mb-0">{{YEAR_SIMPLE}}</h4>
                        <div class="breadcrumb-wrapper col-12 ml-0 pl-0">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="portal.aspx">HOME</a>
                                </li>
                                <li class="breadcrumb-item active">IDP BY EOSL
                                </li>
                            </ol>
                        </div>
                    </div>
                    <div class="col-xl-6 col-lg-6 col-md-12 col-12 pr-0">
                        <div class="row justify-content-end mx-1 " data-html2canvas-ignore="false">
                            <select class="form-control form-control-md w-auto mr-1" style="height: 28px" data-ng-model="year_select" data-ng-change="swich_year(year_select)">
                                <option value="">All</option>
                                <option value="{{dt.CODE}}" data-ng-repeat="dt in dtyear">{{dt.NAME}}</option>
                            </select>
                            <a data-html2canvas-ignore="false" data-ng-click="pfd_print()" class=" btn btn-social  btn-xs btn-outline-danger bg-danger  white "><span class="fa fa-file-pdf-o"></span>generate PDF</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade " id="modal_zoomchart">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #20B2AA;">
                            <h5 class="modal-title white font-weight-bold" id="exampleModalLabel">{{text_zoom_modal}}</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="container">
                                <div id="chart_gap_plan_zoom" class=" w-100"></div>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="content-body">

                <div class="row match-height">
                    <div class="{{arr_div_box_css[$index]}}" data-ng-class="check_dev_type()" id="dev{{$index}}" data-ng-mouseenter="tooltip('dev'+$index)"
                        data-ng-repeat="dt in dtidp_totals" data-toggle="tooltip" data-placement="top" data-original-title="{{dt.TYPE_NAME}}">
                        <div class="card box-shadow-1 mb-1" data-ng-style="{'background-color': arr_css_style2[$index]}">
                            <div class="card-header pb-0 mb-0 card_mp_t" data-ng-style="{'background-color': arr_css_style2[$index]}">
                                <h6 class="white">{{dt.TYPE_NAME}}</h6>
                            </div>
                            <div class="card-body card_mp_b pt-0 mt-0">
                                <div class="row mt-0">
                                    <div class="media-body white text-center mb-0">
                                        <h4 class="font-weight-bold" data-ng-if="dt.PERCENT_COMPLETE == null && dt.PLANS_COMPLETE == null">N/A</h4>
                                        <h4 class="font-weight-bold" data-ng-if="dt.PLANS_COMPLETE != null || dt.PERCENT_COMPLETE != null">{{dt.PERCENT_COMPLETE == null ? 0 : dt.PERCENT_COMPLETE | number:0}}%</h4>
                                    </div>
                                </div>
                                <div class="row font-small-1">
                                    <div class="media-body white text-left">
                                        <span data-ng-if="dt.PLANS_COMPLETE == null">Total N/A</span>
                                        <span data-ng-if="dt.PLANS_COMPLETE != null">Total {{dt.PLANS_COMPLETE | number:0}}</span>
                                    </div>
                                    <div class="media-body white text-right">
                                        <span>Completed</span>
                                        <span data-ng-if="dt.VALUES_COMPLETE == null">N/A</span>
                                        <span data-ng-if="dt.VALUES_COMPLETE != null">{{dt.VALUES_COMPLETE | number:0}}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row match-height">

                    <div class="col-xl-4 col-lg-4 col-md-12 col-sm-12  pr-xl-0 pr-lg-0 mb-sm-1">
                        <div class="card box-shadow-1 mb-0" id="css_div_idp_left">

                            <div class="card-header pb-0 mb-0">
                                <h6 class=" text-uppercase font-weight-bold"><i class="fa fa-address-book-o" aria-hidden="true"></i>&#32;{{text_COMPETENCY}}</h6>
                            </div>

                            <div class="card-body">
                                <div class="row col-12 m-0 p-0">
                                    <div class="col-12 px-0">
                                        <div class="row m-0 p-0 px-0">
                                            <div class="col-6 m-0 p-0 text-left">
                                                <span class="text-left font-italic font-large-1">{{complete_idp == null ? '0' : complete_idp}}</span><br />
                                                <span class="text-left font-italic font-small-2"><i class="ft-circle bg-warning rounded-circle text-warning font-small-2 mr-0" style="height: 12px"></i>&#32;Completed</span>
                                            </div>
                                            <div class="col-6 m-0 p-0 text-right">
                                                <span class="text-right font-italic font-large-1">{{plan_idp == null ? '0' : plan_idp}}</span><br />
                                                <span class="text-right font-italic font-small-3">Total</span>
                                            </div>

                                            <div id="chart_pie_staff_deverlopment" class="height-250  w-100 m-0 p-0 mt-xl-1 mr-0"></div>
                                            <div class="col-12 mt-4 px-0">
                                                <div class="row no-gutters justify-content-between">

                                                    <div class="media col-4" data-ng-repeat="dt in get_dev_type">
                                                        <div class=" text-white d-flex align-items-center justify-content-center rounded-circle" style="height: 40px; width: 40px;" data-ng-class="colorbytype(dt.TYPE)">
                                                            {{dt.PERCENT| number :0 }}%
                                                        </div>
                                                        <div class="media-body">
                                                            <p class="m-0 pl-1 pr-0 font-small-1 text-bold-500">{{dt.TYPE}}</p>
                                                            <h6 class="text-bold-500 pl-1 font-small-3 mb-0">{{dt.TOTAL}} | <small class="pink font-small-3 text-bold-500">{{(dt.TOTAL/plan_idp)*100 | number : 0}}%</small></h6>
                                                            <span class="font-small-1 pl-1">Actual</span>
                                                        </div>
                                                    </div>
                                                    <div class=" d-none">
                                                        <div class="media col-4 d-flex flex-row">
                                                            <div class="bg-teal text-white d-flex align-items-center justify-content-center rounded-circle" style="height: 40px; width: 40px;">
                                                                20%
                                                            </div>
                                                            <div class="media-body">
                                                                <p class="m-0 pl-1 pr-0  font-small-1 text-bold-500">COACHING</p>
                                                                <h6 class="text-bold-500 pl-1 mb-0">118 | <small class="info font-small-3 text-bold-500">20%</small></h6>
                                                                <span class="font-small-1 pl-1">Actual</span>
                                                            </div>
                                                        </div>
                                                        <div class="media col-4">
                                                            <div class="bg-info text-white d-flex align-items-center justify-content-center rounded-circle" style="height: 40px; width: 40px;">
                                                                10%
                                                            </div>
                                                            <div class="media-body">
                                                                <p class="m-0 pl-1 pr-0 font-small-1 text-bold-500">TRAINING</p>
                                                                <h6 class="text-bold-500 pl-1 mb-0">59 | <small class="teal font-small-3 text-bold-500">10%</small> </h6>
                                                                <span class="font-small-1 pl-1">Actual</span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>

                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>
                    <div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 pr-0">
                        <div class="card box-shadow-1 mb-1" id="css_div_idp_center">
                            <div class="card-header pb-0 mb-0">
                                <h6 class=" text-uppercase font-weight-bold text-nowrap">IDP completion by Employee catagories</h6>
                            </div>
                            <div class="card-body pt-0 mt-0 pb-0">
                                <div id="Apex_bar_chart_jobrole" class="w-100"></div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 ">
                        <div class="card box-shadow-1 mb-0" id="css_div_idp_right">

                            <div class="card-body px-0 mt-0 pb-0  mb-1">
                                <div class="card-header pt-0 pb-0 mb-0">
                                    <label class="font-small-3 text-uppercase font-weight-bold">IDP completion againt plan</label>

                                    <select class="form-control form-control-sm form-control block float-right" style="width: 100%; width: 200px; height: 28px"
                                        id="ddlidp_chart_type" data-ng-model="idp_chart_type" data-ng-change="on_change_idp_type()">
                                        <option value="type">By Type</option>
                                        <option value="jobrole">By Employee catagories</option>
                                        <option value="unit">By Unit</option>
                                    </select>

                                </div>

                                <div id="chart_idp_plan" class="w-100"></div>
                                <div data-ng-if="idp_chart_type != 'jobrole'" class="form-group align-self-center m-0 p-0" style="height: 40px; overflow: auto">

                                    <div class="custom-control custom-checkbox float-left" data-ng-repeat="dt in listjobroles_idp">
                                        <b class="btn font-size-small m-0 p-0 " style="width: 12px; height: 12px;"
                                            data-ng-click="swich_type_chart_idp(dt.NAME,dt.STATUS)"
                                            data-ng-style="{'background-color':(dt.STATUS== true?dt.COLOR:'#CCC')}"></b><small>&nbsp{{dt.NAME}} </small>
                                    </div>
                                </div>
                                <center data-ng-if="idp_chart_type == 'jobrole'">
                                <div class="form-check-inline" style="height: 40px; overflow: auto">  
                                    <div class="custom-control custom-checkbox float-left" data-ng-repeat="dt in listjobroles_idp">
                                        <b class="btn font-size-small m-0 p-0 " style="width: 12px; height: 12px;"
                                            data-ng-click="swich_type_chart_idp(dt.NAME,dt.STATUS)"
                                            data-ng-style="{'background-color':(dt.STATUS== true?dt.COLOR:'#CCC')}"></b><small>&nbsp{{dt.NAME}} </small>
                                    </div>
                                </div>
                                </center>

                                <div class="card-header pb-0 mb-0">
                                    <label class=" text-uppercase font-weight-bold">Gap Closing completion againt plan</label>
                                </div>
                                <div id="chart_gap_plan" class="align-self-center w-100"></div>

                                <div data-ng-if="idp_chart_type != 'jobrole'" class="form-group align-self-center m-0 p-0" style="height: 40px; overflow: auto">

                                    <div class="custom-control custom-checkbox float-left" data-ng-repeat="dt in listjobroles_gap">
                                        <b class="btn font-size-small m-0 p-0 " style="width: 12px; height: 12px;"
                                            data-ng-click="swich_type_chart_gap(dt.NAME,dt.STATUS)"
                                            data-ng-style="{'background-color':(dt.STATUS== true?dt.COLOR:'#CCC')}"></b><small>&nbsp{{dt.NAME}} </small>
                                    </div>

                                </div>
                                <center data-ng-if="idp_chart_type == 'jobrole'">
                                <div class="form-check-inline" style="height: 40px; overflow: auto"> 
                                     
                                    <div class="custom-control custom-checkbox float-left" data-ng-repeat="dt in listjobroles_gap">
                                        <b class="btn font-size-small m-0 p-0 " style="width: 12px; height: 12px;"
                                            data-ng-click="swich_type_chart_gap(dt.NAME,dt.STATUS)"
                                            data-ng-style="{'background-color':(dt.STATUS== true?dt.COLOR:'#CCC')}"></b><small>&nbsp{{dt.NAME}} </small>
                                    </div>

                                </div>
                                </center>


                            </div>

                        </div>
                    </div>

                </div>

                <div class="row">
                    <div class="col-xl-12">
                        <div class="card box-shadow-1 " id="css_div_idp_bottom">
                            <div class="card-header pb-0">
                                <h6 class="text-uppercase font-weight-bold">{{text_type}}</h6>
                            </div>
                            <div class="card-body ">
                                <div class="row justify-content-around">

                                    <div class="col-2" data-ng-repeat="dt in idp_overall_units">
                                        <div id="chartradialBar{{dt.UNIT_NAME}}" class="height-200 w-100 cursor-pointer mt-0"></div>
                                        <div class="text-center">
                                            <p class="text-uppercase font-weight-bold m-0">{{dt.UNIT_NAME}}</p>
                                            <a data-ng-show="unit_code == dt.UNIT_NAME || emp_approver == true || emp_admin == true" href="#" class="cursor-pointer font-small-1" data-ng-click="on_click_next(dt.UNIT_NAME)">See detail&#32;<i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="text-center mt-0 mb-0 mt-2">
                    <p class="font-size-xsmall blue-grey">Strictly Confidential (for internal use only)</p>
                </div>
            </div>


        </div>
    </div>



    <div class="loader" id="divLoading" data-html2canvas-ignore="false">
        <h3>
            <i class="fa fa-circle-o-notch fa-spin fa-fw"></i>&#32;Loading&#8230;
        </h3>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="masterpage_js" runat="server">


    <script>
        var app = angular.module('app', [])

        var url_ws_other = "http://tsr-qdms-les.thaioil.localnet/eosl/webservice/wsform_admin_other.asmx";

        var dateNow = new Date(), m = dateNow.getMonth(), y = dateNow.getFullYear();
        var lab = 'EOSL';
        var month_def = moment().format('MMM');
        var year_def = moment().format('YYYY');
        var momentNow = moment();

        //$(function () {
        //    $('[data-toggle="tooltip"]').tooltip()
        //})

        app.controller('ctrlApp', function ($scope, $http) {
            $scope.tooltip = function (id) {

                $('#' + id).tooltip();
            }

            function apply() {
                if ($scope.$root.$$phase != '$apply' && $scope.$root.$$phase != '$digest') {
                    $scope.$apply();
                }
            };
            function CheckBrowser() {
                try {
                    // Safari 3.0+ "[object HTMLElementConstructor]" 
                    var isSafari = /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || (typeof safari !== 'undefined' && safari.pushNotification));
                    // Internet Explorer 6-11
                    var isIE = /*@cc_on!@*/false || !!document.documentMode;
                    // Edge 20+
                    var isEdge = !isIE && !!window.StyleMedia;
                    // Chrome 1 - 71
                    var isChrome = !!window.chrome && (!!window.chrome.webstore || !!window.chrome.runtime);
                    // Blink engine detection
                    var isBlink = (isChrome) && !!window.CSS;

                    if (isSafari == true) { return "isSafari"; }
                    if (isIE == true) { return "isIE"; }
                    if (isEdge == true) { return "isEdge"; }
                    if (isChrome == true) { return "isChrome"; }
                    if (isBlink == true) { return "isBlink"; }
                }
                catch (ex) { }
            }
            function getQueryString() {
                try {

                    var key = false, res = {}, itm = null;
                    // get the query string without the ?
                    var qs = location.search.substring(1);
                    // check for the key as an argument
                    if (arguments.length > 0 && arguments[0].length > 1)
                        key = arguments[0];
                    // make a regex pattern to grab key/value
                    var pattern = /([^&=]+)=([^&]*)/g;
                    // loop the items in the query string, either
                    // find a match to the argument, or build an object
                    // with key/value pairs

                    $scope.session_location_url = qs;

                    while (itm = pattern.exec(qs)) {
                        if (key !== false && decodeURIComponent(itm[1]) === key)
                            return decodeURIComponent(itm[2]);
                        else if (key === false)
                            res[decodeURIComponent(itm[1])] = decodeURIComponent(itm[2]);
                    }

                    return key === false ? res : null;
                } catch{ return ""; }
            }

            var session_user_login = '<%= Session["user_name"]%>'
            //var session_user_login = 'SUTTHIWAT';//eosl
            //var session_user_login = 'SANGCHAI'; //manager - A
            //var session_user_login = 'PREECHANAN'; //manager EOSL-C
            //var session_user_login = 'SOONTHORNA';//employee-->senior EOSL-C-AA
            //var session_user_login = 'JADET'; //employee-->senior EOSL-C-AA
            //var session_user_login = 'SASIPIM'; //employee-->senior EOSL-C-AA

            //var session_user_login = 'SUTEP'; //manager - A
            var session_unit_diff = 'EOSL';
            //alert(session_user_login);
            //ดึงข้อมูลมาตั้งต้น
            page_load();
            function get_data_in_username(unit_name, team_name, unit_def, team_def, action_diff) {
                var user_name = session_user_login;
                var user_id = '';
                var year = $scope.year_select;
                unit_name = "";

                $scope.emp = [];
                $scope.emp_admin = false;
                $scope.emp_approver = false;
                $scope.emp_status = false;
                $scope.emp_dif = false;
                $scope.emp_userdisplay = "";
                $scope.emp_id = "";
                $scope.unit_code = "";
                $scope.team_code = "";
                $scope.job_role = "";
                $scope.emp_teamheader =false;

                if (session_user_login.toUpperCase() == "ADMIN") {
                    $scope.emp_admin = true; $scope.emp_approver = true;
                    if (unit_def != "") { user_name = ""; unit_name = unit_def; team_name = team_def; }
                }

                $.ajax({
                    type: "POST",
                    url: url_ws_other + "/get_emp_data_idp",
                    data: '{"year":"' + year + '","user_name":"' + user_name + '","user_id":"' + user_id + '","unit":"' + unit_name + '","team":"' + team_name + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {

                        debugger;
                        var arr = JSON.parse(data.d);
                        console.log(arr);
                        $scope.emp = arr.emp_details;
                        $scope.emp_status = false;
                        $scope.emp_dif = false;
                        $scope.emp_userdisplay = "";
                        $scope.emp_id = "";
                        try {

                            $scope.emp_userdisplay = arr.emp_details[0].EMPLOYEE_NAME;
                            $scope.emp_id = arr.emp_details[0].EMPLOYEE_ID;
                            $scope.job_role = arr.emp_details[0].JOB_ROLE;
                            $scope.unit_code = arr.emp_details[0].UNIT_CODE;
                            $scope.team_code = arr.emp_details[0].TEAM_CODE;

                            if ($scope.job_role == "manager" && $scope.unit_code == session_unit_diff) { $scope.emp_approver = true; }
                            if (session_user_login == "ADMIN") { $scope.emp_admin = true; $scope.emp_approver = true; }

                            var MAIN_POS_INIDICATOR = arr.emp_details[0].MAIN_POS_INIDICATOR.replace(" ", "");
                            if (MAIN_POS_INIDICATOR.indexOf("ASSISTANTLAB.MANAGER") > -1) {
                                $scope.emp_teamheader = true;
                            } 

                            apply();

                            if ($scope.unit_code.toString() != "" && action_diff == true) {
                                window.location.assign("idp_by_employees_detail.aspx?unit_name=" + $scope.unit_code + "&team_name=" + $scope.team_code +
                                    "&employees_name=" + $scope.emp_userdisplay + "&employees_id=" + $scope.emp_id + "&year=" + $scope.year_select +
                                    "&pass_page=unit");
                            }

                        }
                        catch (e) { }

                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert("error:" + errorMessage);
                        $("#divLoading").hide();
                    }
                });
            }
            $scope.on_click_next = function (unit_name) {
                 
                if ($scope.emp_admin == true) {
                    if (session_unit_diff == unit_name) {
                        //get user in diff
                        get_data_in_username("", "", unit_name, unit_name, true);

                    } else {
                        window.location.assign("idp_by_team.aspx?unit_name=" + unit_name + "&team_name=&year=" + $scope.year_select);
                    }
                    return;
                }
                //จะมีแต่ user ที่มีสิทธิ์เข้าดูข้อมูล IDP ถึงจะมาถึง step นี้
                if ($scope.unit_code == session_unit_diff && $scope.unit_code == unit_name) {
                    //ไปหน้า detail 
                    $scope.emp_status = true;
                    $scope.emp_dif = true;
                }
                else if ($scope.unit_code == session_unit_diff || $scope.unit_code == unit_name) {
                    //ไปหน้า team ตาม unit ตัวเอง
                    $scope.emp_status = true;
                } else {
                    //ไม่มีสิทธิ์เข้าดู unit 
                    $scope.emp_status = false;
                }

                if ($scope.emp_status == true) {

                    if ($scope.emp_dif == true) {
                        window.location.assign("idp_by_employees_detail.aspx?unit_name=" + $scope.unit_code + "&team_name=" + $scope.team_code +
                            "&employees_name=" + $scope.emp_userdisplay + "&employees_id=" + $scope.emp_id + "&year=" + $scope.year_select +
                            "&pass_page=unit");
                    } else {

                        //กรณีที่เป็นพนักงาน Senior
                        if ($scope.job_role != "manager") {
                          
                            if ($scope.emp_teamheader == true) {
                                window.location.assign("idp_by_employees.aspx?unit_name=" + $scope.unit_code + "&team_name=" + $scope.team_code +
                                    "&employees_name=" + $scope.emp_userdisplay + "&employees_id=" + $scope.emp_id + "&year=" + $scope.year_select +
                                    "&pass_page=unit");
                            } else {
                                window.location.assign("idp_by_employees_detail.aspx?unit_name=" + $scope.unit_code + "&team_name=" + $scope.team_code +
                                    "&employees_name=" + $scope.emp_userdisplay + "&employees_id=" + $scope.emp_id + "&year=" + $scope.year_select +
                                    "&pass_page=unit");
                            } 


                        } else {

                            window.location.assign("idp_by_team.aspx?unit_name=" + unit_name + "&team_name=&year=" + $scope.year_select);
                        }
                    }
                } else {
                    //อาจจะต้องทำแจ้งเตือนว่าไม่มีสิทธิ์
                }
            }

            $scope.swich_type_chart_idp = function (d, isChecked) {
                //d=type name  
                var type_name = d;
                var datalg = $scope.listjobroles_idp.filter(function (x) { return x.NAME == type_name });
                if (isChecked == true) {
                    datalg[0].STATUS = false;
                } else {
                    datalg[0].STATUS = true;
                }
                $scope.fillter_type_chart_idp = type_name;

                $("#chart_idp_plan").html("");
                var id_s = "chart_idp_plan";
                get_apex_bar_chart_switch(id_s, 1, 'againt_plan');

            }
            $scope.swich_type_chart_gap = function (d, isChecked) {
                //d=type name  
                var type_name = d;
                var datalg = $scope.listjobroles_gap.filter(function (x) { return x.NAME == type_name });
                if (isChecked == true) {
                    datalg[0].STATUS = false;
                } else {
                    datalg[0].STATUS = true;
                }
                $scope.fillter_type_chart_idp = type_name;

                $("#chart_gap_plan").html("");
                var id_s = "chart_gap_plan";
                get_apex_bar_chart_switch(id_s, 1, 'gap_closing');

            }
            $scope.swich_year = function (d) {
                var year_select = $scope.year_select;
                if (year_select == "") {
                    $scope.YEAR_SIMPLE = "IDP (JAN - " + month_def + " " + year_def + ")";
                } else {
                    if (+year_select < +year_def && year_select != "") {
                        $scope.YEAR_SIMPLE = "IDP (JAN - DEC " + year_select + ")";
                    } else {
                        $scope.YEAR_SIMPLE = "IDP (JAN - " + month_def + " " + year_select + ")";
                    }
                }
                //ตรวรจสอบสิทธิ์ใหม่ตามปี
                get_data_in_username("", "", "", "", "");
                getdata_idp(true);

            }
            $scope.colorbytype = function (type) {
                var color_bg = null;
                if (type == 'PRACTICE') {
                    color_bg = 'bg-pink';
                }
                else if (type == 'COACHING') { color_bg = 'bg-teal'; }
                else { color_bg = 'bg-info'; }

                return color_bg;

            }
            $scope.check_dev_type = function () {
                var len_data = $scope.dtidp_totals.length;
                var width_win = $(window).width();

                var class_css = null;
                if (len_data > 6) {
                    class_css = 'col-xl-3 col-lg-3 col-md-6 col-sm-12';
                }
                if (len_data <= 6) {
                    class_css = 'col-xl-2 col-lg-2  col-md-6 col-sm-12';
                }
                if (width_win <= 973 && width_win > 767) {
                    $scope.arr_div_box_css = ['pl-1', 'pl-0', 'pl-1', 'pl-0', 'pl-1', 'pl-0', 'pl-1', 'pl-0',];
                }
                else if (width_win <= 767) { $scope.arr_div_box_css = ['pl-1', 'pl-1', 'pl-1', 'pl-1', 'pl-1', 'pl-1', 'pl-1', 'pl-1']; }
                else {
                    $scope.arr_div_box_css = ['pl-1', 'pl-0', 'pl-0', 'pl-0', 'pl-1', 'pl-0', 'pl-0', 'pl-0'];
                }
                return class_css
            }

            $scope.on_change_idp_type = function () {

                data_to_chart_gap_again(true);
            }

            function page_load() {

                var year = getQueryString('year') + "";

                $scope.year_select = ((year == null || year == "" || year == "null") ? year_def : year);

                year = $scope.year_select;

                $scope.emp_teamheader = false;
                get_data_in_username("", "", "", "", "");

                $("#chart_idp_plan").html("");
                $("#chart_gap_plan").html("");

                $scope.idp_chart_type = "jobrole";
                $scope.text_type = "IDP Completion By Unit";
                $scope.text_COMPETENCY = "Staff Development ";

                if (+year < +year_def && year != "") {
                    $scope.YEAR_SIMPLE = "IDP (JAN - DEC " + year + ")";
                } else {
                    $scope.YEAR_SIMPLE = "IDP (JAN - " + month_def + " " + year + ")";
                }
                $.ajax({
                    type: "POST",
                    url: url_ws_other + "/get_d_idp_year",
                    data: '{}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        $("#divLoading").show();
                    },

                    success: function (data) {
                        var arr = JSON.parse(data.d);
                        $scope.dtyear = arr.years;
                        apply();
                        getdata_idp();
                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert("error:" + errorMessage);
                        $("#divLoading").hide();
                    }
                });


            }
            function getdata_idp() {

                var user_name = session_user_login;
                var year = $scope.year_select;
                var unit = "";
                var team = "";

                $.ajax({
                    type: "POST",
                    url: url_ws_other + "/get_d_idp_progression",
                    data: '{"year":"' + year + '","unit":"' + unit + '","team":"' + team + '","user_name":"' + user_name + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        $("#divLoading").show();
                    },

                    success: function (data) {
                        var arr = JSON.parse(data.d);
                        console.log(arr);

                        $scope.dtidp_totals = arr.idp_total;

                        $scope.arr_div_box_css = ['pl-1', 'pl-0', 'pl-0', 'pl-0', 'pl-1', 'pl-0', 'pl-0', 'pl-0'];
                        $scope.arr_css = ['bg-info', 'bg-yellow bg-darken-1', ' bg-info bg-lighten-2', 'bg-pink bg-lighten-2', 'bg-blue darken-4', 'bg-success bg-lighten-2'];
                        $scope.arr_css_style = ['#50B4D8', '#9EDDEF', '#F7E5B7', '#96B3C2', '#96B3C2', '#F7E5B7', '#9EDDEF'];
                        $scope.arr_css_style2 = ['#00A5E3', '#8DD7BF', '#FF69C5', '#FF5768', '#FFBF65', '#50B4D8', '#96B3C2'];
                        $scope.arr_css_style2 = ['#00A5E3', '#8DD7BF', '#FF69C5', '#FF5768', '#FFBF65', '#50B4D8', '#96B3C2', '#ea9085'];
                        //colorunit

                        $scope.arr_type_color = $scope.dtidp_totals.map(function (d, i) {
                            var color_select = $scope.arr_css_style2[i];
                            return { TYPE: d.TYPE_NAME, COLOR: color_select }
                        });

                        //Auwat Start 
                        $scope.fillter_type_chart_idp = "";//'#2494CC', '#00E396', '#FEB019', '#FF4560', '#FFFFFF'
                        $scope.fillter_type_chart_gap = "";//'#2494CC', '#00E396', '#FEB019', '#FF4560', '#FFFFFF'
                        $scope.listjobroles_idp = [{ "COLOR": "#2494CC", "NAME": "EOSL/5M", "STATUS": true }];
                        $scope.listjobroles_idp.push({ "COLOR": "#00E396", "NAME": "Senior", "STATUS": true });
                        $scope.listjobroles_idp.push({ "COLOR": "#FEB019", "NAME": "Supervisor", "STATUS": true });
                        $scope.listjobroles_idp.push({ "COLOR": "#FF4560", "NAME": "Junior", "STATUS": true });
                        $scope.listjobroles_gap = angular.copy($scope.listjobroles_idp);
                        //Auwat End

                        $scope.completion_agian_plan = arr.idp_completion_month;
                        $scope.completion_gap_closing = arr.idp_gap_closing_month;
                        $scope.idp_by_jobroles = arr.idp_completion_jobrole;
                        $scope.idp_overall_units = arr.idp_overall_unit;

                        $scope.completion_gap_closing.forEach(function (d) {
                            if (d.BY_TYPE_NAME == 'jobrole') {
                                d.TYPE_CODE = d.TYPE_CODE.toLowerCase();
                                d.TYPE_NAME = d.TYPE_NAME.toLowerCase();
                                if (d.TYPE_CODE == "junior") {
                                    d.TYPE_CODE = "Junior";
                                    d.TYPE_NAME = "Junior";
                                }
                                if (d.TYPE_CODE == "supervisor") {
                                    d.TYPE_CODE = 'Supervisor';
                                    d.TYPE_NAME = 'Supervisor';
                                }
                                if (d.TYPE_CODE == "manager") {
                                    d.TYPE_CODE = "Manager";
                                    d.TYPE_NAME = "Manager";
                                    d.TYPE_CODE = "EOSL/5M";
                                    d.TYPE_NAME = "EOSL/5M";
                                }
                                if (d.TYPE_CODE == "senior") {
                                    d.TYPE_CODE = 'Senior';
                                    d.TYPE_NAME = 'Senior';
                                }
                            }
                        });

                        $scope.completion_agian_plan.forEach(function (d) {
                            if (d.BY_TYPE_NAME == 'jobrole') {
                                d.TYPE_CODE = d.TYPE_CODE.toLowerCase();
                                d.TYPE_NAME = d.TYPE_NAME.toLowerCase();
                                if (d.TYPE_CODE == "junior") {
                                    d.TYPE_CODE = "Junior";
                                    d.TYPE_NAME = "Junior";
                                }
                                if (d.TYPE_CODE == "supervisor") {
                                    d.TYPE_CODE = 'Supervisor';
                                    d.TYPE_NAME = 'Supervisor';
                                }
                                if (d.TYPE_CODE == "manager") {
                                    d.TYPE_CODE = "Manager";
                                    d.TYPE_NAME = "Manager";
                                    d.TYPE_CODE = "EOSL/5M";
                                    d.TYPE_NAME = "EOSL/5M";
                                }
                                if (d.TYPE_CODE == "senior") {
                                    d.TYPE_CODE = 'Senior';
                                    d.TYPE_NAME = 'Senior';
                                }
                            }





                        });
                        $scope.idp_by_jobroles.forEach(function (d) {
                            d.BY_TYPE_NAME = d.BY_TYPE_NAME.toLowerCase();

                            if (d.BY_TYPE_NAME == "junior") {
                                d.BY_TYPE_NAME = "Junior";

                            }
                            if (d.BY_TYPE_NAME == "supervisor") {
                                d.BY_TYPE_NAME = 'Supervisor';

                            }
                            if (d.BY_TYPE_NAME == "manager") {
                                d.BY_TYPE_NAME = "Manager";
                                d.BY_TYPE_NAME = "EOSL/5M";
                            }
                            if (d.BY_TYPE_NAME == "senior") {
                                d.BY_TYPE_NAME = 'Senior';
                            }
                        });

                        data_to_chart_gap_again(true);
                        $scope.idp_overall_units.forEach(function (v, i) {
                            if (v.UNIT_NAME == 'EOSL-A') {
                                $scope.idp_overall_units[i].sorts_unit = 1;
                            } if (v.UNIT_NAME == 'EOSL-B') {
                                $scope.idp_overall_units[i].sorts_unit = 2;
                            } if (v.UNIT_NAME == 'EOSL-C') {
                                $scope.idp_overall_units[i].sorts_unit = 3;
                            }
                            if (v.UNIT_NAME == 'EOSL-E') {
                                $scope.idp_overall_units[i].sorts_unit = 4;
                            }

                            if (v.UNIT_NAME == 'EOSL-F') {
                                $scope.idp_overall_units[i].sorts_unit = 5;
                            }


                        });
                        $scope.idp_overall_units.sort(function (a, b) { return a.sorts_unit - b.sorts_unit });

                        $scope.complete_idp = arr.idp_overall[0].VALUES_COMPLETE;
                        $scope.plan_idp = arr.idp_overall[0].PLANS_COMPLETE;

                        //แยก type PRACTICE,COACHING,TRAINING  จากฟิล type of
                        $scope.get_dev_type = get_type_idp($scope.dtidp_totals);
                        // end //

                        apply();

                        get_apex_bar_chart("Apex_bar_chart_jobrole", 4, 'jobrole');
                        set_chart_pie_main($scope.complete_idp, $scope.plan_idp);
                        $scope.idp_overall_units.forEach(function (d, i) {
                            var chart_name1 = "chartradialBar" + (d.UNIT_NAME);
                            set_chart_pie_sub(arr, chart_name1, i, d.UNIT_NAME);
                        });

                        $(window).on("resize", function () {

                        }).resize();
                        $("#divLoading").hide();
                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert("error:" + errorMessage);

                    }
                });

            }
            function get_type_idp(arr) {
                var arrs = arr;

                var obj = [{ TYPE: "PRACTICE", VALUE: 0, TOTAL: 0, PERCENT: 70 }, { TYPE: "COACHING", VALUE: 0, TOTAL: 0, PERCENT: 20 }, { TYPE: "TRAINING", VALUE: 0, TOTAL: 0, PERCENT: 10 }];
                for (var x in obj) {

                    for (var i in arrs) {

                        if (arr[i].TYPE_OF == obj[x].TYPE) {
                            obj[x].VALUE += arr[i].VALUES_COMPLETE;
                            obj[x].TOTAL += arr[i].PLANS_COMPLETE;

                        }

                    }

                }
                return obj;

            }

            function set_chart_pie_main(complete, plan) {

                var dom = document.getElementById("chart_pie_staff_deverlopment");
                var myChart = echarts.init(dom);

                var math_random = Math.random() * (100 - 0) + 0;
                math_random = math_random.toFixed(0);

                var mathmin = 100 - math_random;
                var xvalues = (complete / plan) * 100;
                var inprogress = (plan - complete);
                //xvalues = 100 - xvalues;
                xvalues = xvalues.toFixed(0);
                colorset_arr = ['#3EBAF5', '#70FFDA', '#C64CEC', '#FF5A8C', '#B51C55', '#5C0FB9', '#D8E175', '#E1A375', '#AEE175', '#75C1E1', '#4A2CEC', '#159E1E', '#DC802D'];

                option = {

                    title: {
                        text: xvalues + '%',
                        x: 'center',
                        y: 'center',
                        textStyle: {
                            fontWeight: 'normal',
                            color: '#5e5f5e',
                            fontSize: '36',
                            fontFamily: 'Montserrat'
                        }
                    },
                    tooltip: {
                        trigger: 'item',
                        //formatter: '{a} <br/>{b}: {c} ({d}%)'
                        formatter: function (param) {

                            var txt = param.name + ' : (' + param.percent.toFixed(0) + '%) ' + param.value + '  Total : ' + plan;

                            return txt
                        }
                    },
                    //color: ['#2493ff', '#16D39A', '#1fceff', '#ff3d86', '#58FF65', '#FFB965', '#73FFF9'],
                    color: ['#FF7D4D', '#c4c4c4'],
                    legend: {
                        show: false,
                        orient: 'vertical',
                        left: '75%',
                        bottom: '-2%',
                        textStyle: {
                            fontSize: 10,
                        },
                        formatter: function (name) {
                            return name;
                        },
                        //align: 'bottom',
                    },
                    series: [
                        {
                            name: 'IDP',
                            type: 'pie',
                            radius: ['60%', '90%'],
                            center: ['50%', '50%'],
                            avoidLabelOverlap: false,
                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            },
                            labelLine: {
                                normal: {
                                    show: false
                                }
                            },
                            data: [
                                {
                                    value: complete,
                                    name: 'Completed',
                                    label: {
                                        show: false,
                                        color: "#5e5f5e"
                                    },
                                    labelLine: {
                                        show: false,
                                        lineStyle: { color: "#5e5f5e" },

                                    }
                                },
                                {
                                    value: inprogress,
                                    name: 'In progress',
                                    label: {
                                        show: false,
                                        color: "#5e5f5e"
                                    },
                                    labelLine: {
                                        show: false,
                                        lineStyle: { color: "#5e5f5e" },

                                    }
                                }
                            ]
                        }
                    ]
                };

                if (option && typeof option === "object") {
                    myChart.setOption(option, true);
                }

                //$(function () {

                //    // Resize chart on menu width change and window resize
                //    $(window).on('resize', resize);

                //    //$('#modalCenter').modal('toggle').on('click', resize);

                //    // Resize function
                //    function resize() {
                //        setTimeout(function () {

                //            // Resize chart
                //            myChart.resize();
                //        }, 200);
                //    }
                //});


            };

            function set_chart_pie_sub(arr, chart_name, number, team_name) {


                var dom = document.getElementById("" + chart_name + "");
                var myChart = echarts.init(dom);

                var TeamS = $scope.idp_overall_units.map(function (d) { return d.UNIT_CODE });

                var data_d = $scope.idp_overall_units.find(function (d) { return d.UNIT_CODE == TeamS[number] });
                var total = (data_d.PLANS_COMPLETE == null) ? 0 : data_d.PLANS_COMPLETE;
                var complete = (data_d.VALUES_COMPLETE == null) ? 0 : data_d.VALUES_COMPLETE;
                try {
                    var inprogress = (total - complete);
                    var percenA = (complete / total) * 100;
                }
                catch (ex) { console.log(ex); }

                if (isNaN(percenA) == false) {
                    percenA = percenA.toFixed(0);
                }
                else { percenA = 0; }

                //colorset_arr = ['#3EBAF5', '#70FFDA', '#C64CEC', '#FF5A8C', '#B51C55', '#5C0FB9', '#D8E175', '#E1A375', '#AEE175', '#75C1E1', '#4A2CEC', '#159E1E', '#DC802D'];
                //E >> TLB : #009688
                //F >> TPX : #FF4081
                //C >> TOP : #2196F3
                colorset_arr = ['#B51C55', '#FFB638', '#70FFDA', '#2196F3', '#009688', '#FF4081'];

                option = {
                    title: [
                        {
                            text: '' + percenA + '%',
                            textStyle: {
                                fontSize: 24,
                                color: "#16D39A",
                                fontFamily: 'Montserrat'
                            },
                            y: '35%',
                            left: 'center'
                        }, {
                            text: complete + '/' + total,
                            textStyle: {
                                fontSize: 12,
                                color: '#5e5f5e',
                                fontFamily: 'Montserrat',
                                fontWeight: 'bold'
                            },
                            y: '50%',
                            left: 'center'
                        }, {
                            text: 'Completed/Total',
                            textStyle: {
                                fontSize: 8,
                                color: '#5e5f5e',
                                fontFamily: 'Montserrat'
                            },
                            y: '58%',
                            left: 'center'
                        },

                    ],

                    tooltip: {
                        trigger: 'item',
                        //formatter: '{a} <br/>{b}: {c} ({d}%)'
                        formatter: function (param) {
                            var txt = param.name + ': ' + param.value + ' (' + param.percent.toFixed(0) + '%) Total: ' + total;

                            return txt
                        }
                    },
                    color: ['' + colorset_arr[number] + '', '#c4c4c4'],

                    series: [
                        {
                            name: 'IDP',
                            type: 'pie',

                            radius: ['60%', '85%'],
                            avoidLabelOverlap: false,
                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            },
                            label: {
                                show: false,
                                fontSize: 8,
                            },
                            labelLine: {
                                normal: {
                                    show: false,
                                    length: 1,
                                    lineStyle: {
                                        //color: "#000",
                                        width: 1,
                                    }
                                }
                            },
                            data: [
                                {
                                    value: complete, name: 'Complete',
                                    label: {
                                        show: false,
                                        color: "#5e5f5e",
                                        fontSize: '6',
                                        normal: {
                                            formatter: '{b}\n{d}%',
                                            show: false,
                                            position: 'start'
                                        },
                                    },
                                    labelLine: {
                                        show: false,



                                    }
                                },
                                {
                                    value: inprogress, name: 'In progress',
                                    label: {
                                        show: false,
                                        color: "#5e5f5e"
                                    },
                                    labelLine: {
                                        show: false,
                                        lineStyle: { color: "#5e5f5e" },

                                    }
                                }
                            ]
                        }
                    ]
                };

                //$('#' + chart_name + '').on('click', function (params) {
                //    getusername();
                //    // window.open('https://www.baidu.com/s?wd=' + TeamS[number]);
                //    window.location.assign("IDP_by_team.aspx?unit_name=" + TeamS[number]);
                //    // pageload(TeamS[number]);
                //});

                if (option && typeof option === "object") {
                    myChart.setOption(option, true);
                }

                //$(function () {

                //    // Resize chart on menu width change and window resize
                //    $(window).on('resize', resize);
                //    $(".menu-toggle").on('click', resize);
                //    //$('#modalCenter').modal('toggle').on('click', resize);

                //    // Resize function
                //    function resize() {
                //        setTimeout(function () {

                //            // Resize chart
                //            myChart.resize();
                //        }, 200);
                //    }
                //});



            };

            function data_to_chart_gap_again(bool) {
                if (bool == true) {
                    $('#chart_idp_plan').html('');
                    $('#chart_gap_plan').html('');
                }

                //Auwat Start  
                $scope.fillter_type_chart_idp = "";
                $scope.fillter_type_chart_gap = "";
                var chart_type = $scope.idp_chart_type; // idp_chart_type-- > type, jobrole, unit
                if (chart_type == "type") {

                    $scope.listjobroles_idp = $scope.dtidp_totals.map(function (d, i) {
                        var color_select = $scope.arr_css_style2[i];
                        return { COLOR: color_select, NAME: d.TYPE_NAME, STATUS: true }
                    });

                } else if (chart_type == "jobrole") {
                    $scope.listjobroles_idp = [{ "COLOR": "#2494CC", "NAME": "EOSL/5M", "STATUS": true }];
                    $scope.listjobroles_idp.push({ "COLOR": "#00E396", "NAME": "Senior", "STATUS": true });
                    $scope.listjobroles_idp.push({ "COLOR": "#FEB019", "NAME": "Supervisor", "STATUS": true });
                    $scope.listjobroles_idp.push({ "COLOR": "#FF4560", "NAME": "Junior", "STATUS": true });

                } else if (chart_type == "unit") {
                    $scope.listjobroles_idp = [{ "COLOR": "#ff5722", "NAME": "EOSL", "STATUS": true }];
                    $scope.listjobroles_idp.push({ "COLOR": "#FFB638", "NAME": "EOSL-A", "STATUS": true });
                    $scope.listjobroles_idp.push({ "COLOR": "#70FFDA", "NAME": "EOSL-B", "STATUS": true });
                    $scope.listjobroles_idp.push({ "COLOR": "#2196F3", "NAME": "EOSL-C", "STATUS": true });
                    $scope.listjobroles_idp.push({ "COLOR": "#009688", "NAME": "EOSL-E", "STATUS": true });
                    $scope.listjobroles_idp.push({ "COLOR": "#FF4081", "NAME": "EOSL-F", "STATUS": true });

                }
                $scope.listjobroles_gap = angular.copy($scope.listjobroles_idp);
                //Auwat End

                var id_s = "chart_idp_plan";
                get_apex_bar_chart_switch(id_s, 1, 'againt_plan');
                var id_s = "chart_gap_plan";
                get_apex_bar_chart_switch(id_s, 1, 'gap_closing');

            }

            function get_data_binde_chart(data, xtype, xdef) {


                if (xtype == 'jobrole') {

                    $scope.data_tooltip_jobrole = data;
                    var arrdupicate = [];
                    var objs = [];
                    var obj = [];



                    data.forEach(function (d) {
                        var find_index = arrdupicate.findIndex(function (x) { return x == d.BY_TYPE_NAME });

                        var filter_d = 12;
                        if (find_index == -1) {
                            var obj_x = { name: d.BY_TYPE_NAME, data: [], value: 0, xtotal: 0 };
                            objs.push(obj_x);
                        }
                        arrdupicate.push(d.BY_TYPE_NAME);
                    });

                    for (var i in objs) {

                        for (var x in data) {
                            if (data[x].BY_TYPE_NAME == objs[i].name) {
                                objs[i].xtotal += data[x].PLANS_COMPLETE;
                            }

                        }
                    }

                    for (var i in objs) {

                        for (var x in data) {

                            if (objs[i].name == data[x].BY_TYPE_NAME) {
                                objs[i].value += data[x].VALUES_COMPLETE;

                            }

                        }
                    }


                    var job_role = ['EOSL/5M', 'Senior', 'Supervisor', 'Junior'];
                    for (var i in job_role) {
                        for (var x in objs) {

                            if (job_role[i] == objs[x].name) {
                                //complate
                                obj.push(objs[x].value);

                                break;

                            }
                        }

                    }


                }
                else {

                    var type_name = $scope.idp_chart_type;
                    var data = data.filter(function (x) { return x.BY_TYPE_NAME == type_name });

                    var d_type = ['EOSL/5M', 'EOSL/5M total', 'Senior', 'Senior total', 'Supervisor', 'Supervisor total', 'Junior', 'Junior total'];
                    if ($scope.fillter_type_chart_idp != "" || $scope.fillter_type_chart_gap != "") {
                        //Auwat Start 
                        d_type = [];
                        var xfillter_val = [];
                        if (xtype == 'gap_closing') {
                            var datalg = $scope.listjobroles_gap;
                        } else {
                            var datalg = $scope.listjobroles_idp;
                        }
                        for (var i = 0; i < datalg.length; i++) {
                            if (datalg[i].STATUS == true) {
                                xfillter_val.push(datalg[i].NAME);
                                d_type.push(datalg[i].NAME);
                                d_type.push(datalg[i].NAME + " total");
                            }
                        }
                        var data = data.filter(function (x) {
                            return (
                                (x.TYPE_NAME == xfillter_val[0] && xfillter_val[0] != "")
                                || (x.TYPE_NAME == xfillter_val[1] && xfillter_val[1] != "")
                                || (x.TYPE_NAME == xfillter_val[2] && xfillter_val[2] != "")
                                || (x.TYPE_NAME == xfillter_val[3] && xfillter_val[3] != ""))
                        });
                        //Auwat End

                    }

                    if (xtype == 'gap_closing') {
                        $scope.data_tooltip_gap = data;
                    }
                    else {
                        $scope.data_tooltip_again = data;
                    }
                    //กรณที่เปลียน type
                    var arrdupicate = [];
                    var obj = [];
                    var objf = [];

                    data.forEach(function (d) {
                        var find_index = arrdupicate.findIndex(function (x) { return x == d.TYPE_CODE });

                        var filter_d = 12;
                        if (find_index == -1) {

                            var nameS = d.TYPE_CODE == null ? 'N/A' : d.TYPE_CODE;
                            var obj_x = { name: nameS, data: Array(filter_d).fill(0), stype: xtype, xtotal: 0 };
                            objf.push(obj_x);

                            //total
                            obj_x = { name: nameS + " total", data: Array(filter_d).fill(0), stype: xtype, xtotal: 0 };
                            objf.push(obj_x);
                        }

                        arrdupicate.push(d.TYPE_CODE);

                    });

                    //sort Manager,Senior,Supervisor,Junior
                    if (type_name == 'jobrole') {

                        //var d_type = ['EOSL/5M', 'EOSL/5M total', 'Senior', 'Senior total', 'Supervisor', 'Supervisor total', 'Junior', 'Junior total'];
                    }
                    else {
                        var d_type = objf.map(function (d) { return (d.name == null) ? 'N/A' : d.name });
                    }

                    // add data
                    for (var i in d_type) {
                        for (var x in objf) {

                            if (d_type[i] == objf[x].name) {
                                //by type
                                obj.push(objf[x]);
                                break;

                            }

                        }
                    }

                    //push ค่า ใส่ obj - complete
                    //push ค่า ใส่ obj - total
                    //หา total 
                    var arr_total_month = Array(12).fill(0);
                    for (var i in obj) {

                        for (var x in data) {
                            obj[i].xtotal += (data[x].PLANS_COMPLETE == null) ? 0 : data[x].PLANS_COMPLETE;

                            if (obj[i].name == data[x].TYPE_CODE) {
                                var month_index = (data[x].MONTH - 1);
                                var vcomplete = (data[x].VALUES_COMPLETE == null) ? 0 : data[x].VALUES_COMPLETE;
                                var vplan = (data[x].PLANS_COMPLETE == null) ? 0 : data[x].PLANS_COMPLETE;
                                var vtotal = vplan - vcomplete;

                                if (xdef == true) {

                                    obj[i].data[month_index] += (data[x].PLANS_COMPLETE == null) ? 0 : data[x].PLANS_COMPLETE;
                                    obj[+i + 1].data[month_index] += (vtotal == null) ? 0 : vtotal; //total plan 
                                    arr_total_month[month_index] += 0;

                                } else {

                                    obj[i].data[month_index] += +vcomplete;
                                    obj[+i + 1].data[month_index] += (vtotal == null) ? 0 : vtotal; //total plan

                                    arr_total_month[month_index] += (data[x].PLANS_COMPLETE == null) ? 0 : data[x].PLANS_COMPLETE;
                                }

                            }

                        }

                    }


                    for (var i in obj) {
                        for (var x in obj[i].data) {
                            var data_main = obj[i].data;
                            var sum_val = +(((data_main[x] == null) ? 0 : data_main[x] / arr_total_month[x]) * 100);
                            obj[i].data[x] = isNaN(sum_val) == true ? 0 : sum_val;
                        }


                    }
                }

                return obj;
            }

            function get_apex_bar_chart(chart_name, type_number, xtype) {
                var set_position = "bottom";
                var istack = true;
                var xmax = 100;
                var color_set = ['#F06292', '#FDD734'];
                var color_set_plan = ['#F06292', '#FDD734'];
                var heightZ = 0;
                var xtextXaix = moment.monthsShort();

                var type_name = $scope.idp_chart_type;
                var dataseries = null;

                var Labels_offsetY = -15;
                //หา total
                var total = null;

                var grid_def = null;

                if (type_number == 1) {

                    var Labels_offsetY = 10;
                    var xcolumnWidth = '80%' //var xcolumnWidth = '80%' 
                    var namechart = chart_name.indexOf('gap_plan');
                    if (namechart == -1) {
                        var data_d = $scope.completion_agian_plan
                    }
                    else {
                        var data_d = $scope.completion_gap_closing
                    }
                    var data_x = get_data_binde_chart(data_d, xtype);
                    dataseries = data_x;

                    //กรณีเป็น AGAINT PLAN
                    var xoffsetY = 0;
                    var distributed = false;
                    var tick_amount = 4;
                    xmax = 100;
                    heightZ = 200;
                    grid_def = {

                        yaxis: {
                            lines: {
                                show: false
                            }
                        },
                        padding: {
                            top: -15,
                            right: 10,
                            bottom: -10,
                            left: 10

                        },
                    }

                    if (type_name == "type") {

                        var Labels_offsetY = 5;
                        var data_type_select = $scope.arr_type_color;
                        var colorset_unit_fill = [];
                        data_type_select.forEach(function (d, s) {
                            dataseries.forEach(function (x, i) {
                                if (x.name == d.TYPE) {
                                    dataseries[i].sort_by = (s + 1);
                                    dataseries[i].color_j = d.COLOR;
                                    colorset_unit_fill.push(d.COLOR);
                                } else if (x.name.replace(" total", "") == d.TYPE) {
                                    dataseries[i].sort_by = (s + 1);
                                    dataseries[i].color_j = '#ccc';
                                    colorset_unit_fill.push('#FFFFFF');
                                }
                            });
                        });

                        dataseries.sort(function (a, b) { return a.sort_by - b.sort_by });
                        color_set = dataseries.map(function (d) { return d.color_j });
                        color_set.push('#FFFFFF');
                        colorset_unit_fill.push('#FFFFFF');
                    }
                    else if (type_name == 'unit') {

                        var colorset_unit = ['#ff5722', '#FFB638', '#70FFDA', '#2196F3', '#009688', '#FF4081', '#FFFFFF'];
                        var colorset_unit_plan = ['#ccc', '#ccc', '#ccc', '#ccc', '#ccc', '#ccc', '#FFFFFF'];
                        var colorset_unit_fill = ['#ff5722', '#FFFFFF', '#FFB638', '#FFFFFF', '#70FFDA', '#FFFFFF', '#2196F3', '#FFFFFF', '#009688', '#FFFFFF', '#FF4081', '#FFFFFF', '#FFFFFF'];

                        dataseries.forEach(function (x, i) {

                            if (x.name == 'EOSL') {
                                dataseries[i].sort_by = (1);
                                dataseries[i].color_j = colorset_unit[0];
                            }
                            else if (x.name == 'EOSL-A') { dataseries[i].sort_by = (2); dataseries[i].color_j = colorset_unit[1]; }
                            else if (x.name == 'EOSL-B') { dataseries[i].sort_by = (3); dataseries[i].color_j = colorset_unit[2]; }
                            else if (x.name == 'EOSL-C') { dataseries[i].sort_by = (4); dataseries[i].color_j = colorset_unit[3]; }
                            else if (x.name == 'EOSL-E') { dataseries[i].sort_by = (5); dataseries[i].color_j = colorset_unit[4]; }
                            else if (x.name == 'EOSL-F') { dataseries[i].sort_by = (6); dataseries[i].color_j = colorset_unit[5]; }
                            else if (x.name == 'EOSL total') {
                                dataseries[i].sort_by = (1);
                                dataseries[i].color_j = colorset_unit_plan[0];
                            }
                            else if (x.name == 'EOSL-A total') { dataseries[i].sort_by = (2); dataseries[i].color_j = colorset_unit_plan[1]; }
                            else if (x.name == 'EOSL-B total') { dataseries[i].sort_by = (3); dataseries[i].color_j = colorset_unit_plan[2]; }
                            else if (x.name == 'EOSL-C total') { dataseries[i].sort_by = (4); dataseries[i].color_j = colorset_unit_plan[3]; }
                            else if (x.name == 'EOSL-E total') { dataseries[i].sort_by = (5); dataseries[i].color_j = colorset_unit_plan[4]; }
                            else if (x.name == 'EOSL-F total') { dataseries[i].sort_by = (6); dataseries[i].color_j = colorset_unit_plan[5]; }

                        });

                        dataseries.sort(function (a, b) { return a.sort_by - b.sort_by });
                        color_set = dataseries.map(function (d) { return d.color_j });
                        color_set.push('#FFFFFF');

                    }
                    else if (type_name == 'jobrole') {

                        var colorset_unit = ['#2494CC', '#00E396', '#FEB019', '#FF4560', '#FFFFFF'];
                        var colorset_unit_plan = ['#ccc', '#ccc', '#ccc', '#ccc', '#FFFFFF'];
                        var colorset_unit_fill = ['#2494CC', "#ffffff", '#00E396', "#ffffff", '#FEB019', "#ffffff", '#FF4560', "#ffffff", "#ffffff"];


                        dataseries.forEach(function (x, i) {
                            if (x.name == 'EOSL/5M') {
                                dataseries[i].sort_by = (1);
                                dataseries[i].color_j = colorset_unit[0];
                            }
                            else if (x.name == 'Senior') { dataseries[i].sort_by = (3); dataseries[i].color_j = colorset_unit[1]; }
                            else if (x.name == 'Supervisor') { dataseries[i].sort_by = (4); dataseries[i].color_j = colorset_unit[2]; }
                            else if (x.name == 'Junior') { dataseries[i].sort_by = (5); dataseries[i].color_j = colorset_unit[3]; }
                            else if (x.name == 'EOSL/5M total') {

                                dataseries[i].sort_by = (1);
                                dataseries[i].color_j = colorset_unit_plan[0];
                            }
                            else if (x.name == 'Senior total') { dataseries[i].sort_by = (3); dataseries[i].color_j = colorset_unit_plan[1]; }
                            else if (x.name == 'Supervisor total') { dataseries[i].sort_by = (4); dataseries[i].color_j = colorset_unit_plan[2]; }
                            else if (x.name == 'Junior total') { dataseries[i].sort_by = (5); dataseries[i].color_j = colorset_unit_plan[3]; }


                        });
                        dataseries.sort(function (a, b) { return a.sort_by - b.sort_by });
                        color_set = dataseries.map(function (d) { return d.color_j });
                        color_set.push('#FFFFFF');
                    }

                    var c_yoffset = 0;
                    dataseries.push({
                        name: ""
                        , data: Array(12).fill(20)
                        , stype: ""
                        , xtotal: 0
                    });

                }

                if (type_number == 4) {
                    //กรณี AGAINT PLAN BY JOB ROLE
                    var xcolumnWidth = '50%'
                    var data_d = $scope.idp_by_jobroles;
                    var data_x = get_data_binde_chart(data_d, xtype);

                    var tick_amount = 5;
                    var c_yoffset = 20;
                    grid_def = {

                        yaxis: {
                            lines: {
                                show: true
                            }
                        },
                        padding: {
                            top: -26,
                            right: 10,
                            bottom: -5,
                            left: 10
                        },
                    }
                    var max = 100
                    var xoffsetY = -15;
                    var distributed = true;

                    xtextXaix = ['EOSL/5M', 'Senior', 'Supervisor', 'Junior'];

                    //sumtotal  
                    var data_d = data_x.map(function (d, i) {
                        var role = xtextXaix[i];
                        var total = $scope.idp_by_jobroles.filter(function (d) { return d.BY_TYPE_NAME == role }).reduce(function (a, b) {
                            return (a + b.PLANS_COMPLETE)
                        }, 0);
                        var push_d = (d / total) * 100;
                        return +push_d.toFixed(0)
                    });

                    color_set = ['#2494CC', '#00E396', '#FEB019', '#FF4560'];

                    var dataseries = [{
                        name: "Completed",
                        xtotal: total,
                        data: data_d
                    }];

                    heightZ = "412";

                    istack = false;
                }

                var options = {
                    series: dataseries,

                    chart: {
                        events: {
                            click: function (event, chartContext, config) {
                            }
                        },
                        height: heightZ,
                        type: 'bar',
                        toolbar: {
                            show: false,
                        },
                        offsetX: -10,
                        offsetY: c_yoffset,

                        stacked: istack,
                        sparkline: {
                            enabled: false,
                        },
                        events: {

                            legendClick: function (chartContext, seriesIndex, config) {

                            }

                        }
                    },

                    plotOptions: {
                        bar: {
                            columnWidth: xcolumnWidth,
                            distributed: distributed,
                            dataLabels: {
                                position: 'top'
                            },
                        }
                    },
                    colors: color_set,
                    dataLabels: {
                        enabled: true,
                        position: 'top',
                        offsetY: Labels_offsetY,
                        offsetX: 0,

                        formatter: function (val, opts) {

                            var sindex = opts.seriesIndex;//type = role
                            var total = opts.w.config.series[0].xtotal;
                            var dindex = opts.dataPointIndex;
                            var serise = opts.w.globals.series;

                            if (type_number == 1) {

                                var len_serise = serise.length - 1;
                                if (opts.seriesIndex != len_serise) { return ""; }

                                //function แบบเดียวกันกับ tooltip
                                var sindex = opts.seriesIndex;
                                var dindex = opts.dataPointIndex;
                                var serise = opts.series;

                                try {

                                    if (opts.w.config.series[0].stype == 'againt_plan' || opts.w.config.series[0].stype == 'gap_closing') {
                                        if (opts.w.config.series[0].stype == 'againt_plan') {
                                            $scope.data_tooltip = $scope.data_tooltip_again;
                                        }
                                        else {
                                            $scope.data_tooltip = $scope.data_tooltip_gap;
                                        }
                                        var data_xs = data_x.find(function (d, i, s) { return i == sindex });
                                        //ยอดcomplate 
                                        var total_complate_month = $scope.data_tooltip.filter(function (m) { return m.MONTH == (dindex + 1) }).reduce(function (a, b) { return a + b.VALUES_COMPLETE }, 0);
                                        //total ทั้งเดือน
                                        var total_plan_all = $scope.data_tooltip.filter(function (d) { return d.MONTH == (dindex + 1) }).reduce(function (a, b) { return a + b.PLANS_COMPLETE }, 0);
                                        var percent_total = ((total_complate_month / total_plan_all) * 100).toFixed(0);

                                        if (percent_total.replace("NaN", "") == "") { return ""; } else { return percent_total.replace("NaN", "") + "%"; }

                                    }

                                } catch{ return ""; }
                                return "";
                            }
                            else {
                                val = val.toFixed(0);
                                if (val == 100) {
                                    val = '';
                                }
                                else {
                                    if (val != '') {
                                        if (val == 0) {
                                            val = '';
                                        }
                                        else {

                                            val = val + "%";
                                        }
                                    }

                                }
                            }


                            return val;
                        },

                        style: {
                            colors: ['#000'],
                            fontSize: '8px',
                            fontFamily: 'Montserrat, sans-serif',
                        },

                    },

                    xaxis: {
                        labels: {
                            rotate: -45
                        },
                        axisTicks: {
                            show: false,
                        },
                        categories: xtextXaix,
                        labels: {
                            show: true,
                            style: {
                                colors: '#5E5F5E',
                                fontSize: '10px',
                                fontFamily: 'Montserrat, sans-serif',
                            }
                        },
                    },
                    yaxis: {

                        axisBorder: {
                            show: false,
                        },
                        axisTicks: {
                            show: false,
                            color: '#78909C',
                        },

                        crosshairs: {
                            show: false,
                        },

                        tickAmount: tick_amount,
                        min: 0,
                        max: xmax,

                        labels: {
                            show: true,
                            align: 'right',
                            //minWidth: 0,
                            //maxWidth: 100,
                            style: {
                                color: '#5E5F5E',
                                fontSize: '8px',
                                //fontFamily: 'Helvetica, Arial, sans-serif',
                                fontFamily: 'sans-serif',
                                cssClass: 'apexcharts-yaxis-label',
                            },
                            offsetX: 0,
                            offsetY: 0,
                            rotate: 0,

                            formatter: function (value) {
                                var xvalue = value.toFixed(0);
                                if (type_number == 1) {

                                    return xvalue + " %";
                                }
                                else {
                                    return xvalue + " %"
                                }
                            },
                        },

                    },
                    grid: grid_def,
                    legend: {
                        position: set_position,
                        show: true,
                        markers: {
                            fillColors: colorset_unit_fill

                        },
                        formatter: function (seriesName, opts) {
                            if (seriesName.indexOf(' total') > -1) {
                                return ''
                            }
                            return [seriesName]
                        },
                        position: 'bottom',
                        horizontalAlign: 'center',
                        offsetY: -10,
                    },
                    tooltip: {
                        shared: false,
                        y: {

                            formatter: function (val, opts) {
                                try {
                                    var sindex = opts.seriesIndex; // ตำแน่งของ role
                                    var total = opts.w.config.series[0].xtotal;//ยอดรวมทั้งกราฟ plan
                                    var dindex = opts.dataPointIndex;// ตำแน่งของ เดือน
                                    var serise = opts.series;

                                    //ค่า actual = 8 จากทั้งหมดของแท่งนั้น = 262  คิดเป็น 3 % // ค่าของ plan ในเดือนนั่น
                                    //แล้ว total ค่า actual = 8 จากทั้งหมดของทั้งหมด = 361  คิดเป็น 2 % าของ plan ในเดือนนั่น 

                                    var text = '';
                                    if (opts.w.config.series[0].stype == 'againt_plan' || opts.w.config.series[0].stype == 'gap_closing') {


                                        try {
                                            if (opts.w.config.series[sindex].name.indexOf(" total") > -1) {
                                                sindex -= 1;
                                            }

                                            if (opts.w.config.series[0].stype == 'againt_plan') {
                                                $scope.data_tooltip = $scope.data_tooltip_again;
                                            }
                                            else {
                                                $scope.data_tooltip = $scope.data_tooltip_gap;
                                            }

                                            var data_xs = data_x.find(function (d, i, s) { return i == sindex });
                                            if (data_xs.name == "") {
                                                return text;
                                            }
                                            var data_d = $scope.data_tooltip.filter(function (d) { return d.TYPE_CODE == data_xs.name });
                                            var data_plan = $scope.data_tooltip.filter(function (d) { return d.MONTH == (dindex + 1) });
                                            var val_by_dataset = data_d.filter(function (d) { return d.MONTH == (dindex + 1) });

                                            var val_by_month = 0;
                                            try {
                                                val_by_month = val_by_dataset[0].VALUES_COMPLETE == null ? 0 : val_by_dataset[0].VALUES_COMPLETE;
                                            } catch{ }

                                            //ยอดcomplate
                                            total_complate = data_d.reduce(function (a, b) { return a + b.VALUES_COMPLETE }, 0);

                                            var total_plan_all = data_plan.reduce(function (a, b) { return a + b.PLANS_COMPLETE }, 0);

                                            var total_plan_month = val_by_dataset.filter(function (m) { return m.VALUES_COMPLETE != null }).reduce(function (a, b) { return a + b.PLANS_COMPLETE }, 0);

                                            var percent_actual = (val_by_month / total_plan_month) * 100;
                                            var percent_total = (val_by_month / total_plan_all) * 100;

                                            text = "Actual: " + (percent_actual.toFixed(0) + "% ").replace("NaN%", "0%") + "(" + val_by_month + "/" + total_plan_month + ") Total: " + percent_total.toFixed(0) + "% (" + val_by_month + "/" + total_plan_all + ")";

                                        } catch (ex) {

                                            return ex;
                                        }
                                    }
                                    else {

                                        if ("IDP COMPLETION BY EMPLOYEE CATAGORIES" == "IDP COMPLETION BY EMPLOYEE CATAGORIES") {
                                            var data_serise = xtextXaix;
                                            var n_jobrole = data_serise[dindex];
                                            //DATA BY JOBROLE
                                            var d_select_jobrole = $scope.data_tooltip_jobrole;
                                            //alert(n_jobrole);
                                            //TOTAL PLAN
                                            var total = opts.w.config.series[0].xtotal;
                                            //COMPLETE BY ROLE
                                            var total_complete = d_select_jobrole.filter(function (d) { return d.BY_TYPE_NAME == n_jobrole }).reduce(function (a, b) { return a + b.VALUES_COMPLETE }, 0);
                                            var total_by_role = d_select_jobrole.filter(function (d) { return d.BY_TYPE_NAME == n_jobrole }).reduce(function (a, b) { return a + b.PLANS_COMPLETE }, 0);
                                            //var actual = ((val * total) / 100).toFixed(0);

                                            var actual = total_complete;

                                            var percent_actual = (actual / actual) * 100;
                                            var percent_total = (actual / total_by_role) * 100;

                                            text = "Actual:" + percent_total.toFixed(0) + "% (" + actual + "/" + total_by_role + ")";
                                        }

                                    }

                                    return text;

                                } catch{ return "Plan :" + val; }
                            }
                        },
                        x: {
                            show: true,
                            formatter: function (val, opts) {

                                try {
                                    var sindex = opts.seriesIndex;
                                    var total = opts.w.config.series[0].xtotal;
                                    var dindex = opts.dataPointIndex;
                                    var serise = opts.series;
                                    var actual = serise[sindex][dindex];
                                    var tofmonth = 0;
                                    var result = val;
                                    if (opts.w.config.series[0].stype == 'againt_plan' || opts.w.config.series[0].stype == 'gap_closing') {
                                        if (opts.w.config.series[0].stype == 'againt_plan') {
                                            $scope.data_tooltip = $scope.data_tooltip_again;
                                        }
                                        else {
                                            $scope.data_tooltip = $scope.data_tooltip_gap;
                                        }
                                        var data_xs = data_x.find(function (d, i, s) { return i == sindex });

                                        var data_d = $scope.data_tooltip.filter(function (d) { return d.TYPE_CODE == data_xs.name });
                                        var data_plan = $scope.data_tooltip.filter(function (d) { return d.MONTH == (dindex + 1) });

                                        //ยอดcomplate
                                        total_complate = data_d.reduce(function (a, b) { return a + b.VALUES_COMPLETE }, 0);
                                        var total_complate_month = $scope.data_tooltip.filter(function (m) { return m.MONTH == (dindex + 1) }).reduce(function (a, b) { return a + b.VALUES_COMPLETE }, 0);
                                        //total ทั้งเดือน
                                        var total_plan_all = $scope.data_tooltip.filter(function (d) { return d.MONTH == (dindex + 1) }).reduce(function (a, b) { return a + b.PLANS_COMPLETE }, 0);
                                        var percent_total = ((total_complate_month / total_plan_all) * 100).toFixed(0);

                                        if (percent_total.replace("NaN", "") == "") { percent_total = ""; } else {
                                            percent_total = percent_total + '%'
                                        }

                                        return result = val + ' : ' + percent_total + ' (' + total_complate_month + '/' + total_plan_all + ')';

                                    }
                                    return result;

                                } catch{ return "Plan :" + val; }
                            }
                        },
                    },
                    labels: ['Plan', 'Completed']
                };

                var chart = new ApexCharts(document.querySelector("#" + chart_name), options);
                chart.render();

                $(window).on("resize", function () { }).resize();
            }

            function get_apex_bar_chart_switch(chart_name, type_number, xtype) {
                var set_position = "bottom";
                var istack = true;
                var xmax = 100;
                var color_set = ['#F06292', '#FDD734'];
                var color_set_plan = ['#F06292', '#FDD734'];
                var heightZ = 0;
                var xtextXaix = moment.monthsShort();

                var type_name = $scope.idp_chart_type;
                var dataseries = null;

                var Labels_offsetY = -15;
                //หา total
                var total = null;

                var grid_def = null;

                if (type_number == 1) {

                    var Labels_offsetY = 10;
                    var xcolumnWidth = '80%' //var xcolumnWidth = '80%' 
                    var namechart = chart_name.indexOf('gap_plan');
                    if (namechart == -1) {
                        var data_d = $scope.completion_agian_plan
                    }
                    else {
                        var data_d = $scope.completion_gap_closing
                    }
                    var data_x = get_data_binde_chart(data_d, xtype);
                    dataseries = data_x;

                    //กรณีเป็น AGAINT PLAN
                    var xoffsetY = 0;
                    var distributed = false;
                    var tick_amount = 4;
                    xmax = 100;
                    heightZ = 180;
                    grid_def = {

                        yaxis: {
                            lines: {
                                show: false
                            }
                        },
                        padding: {
                            top: 0,
                            right: 10,
                            bottom: 0,
                            left: 10

                        },
                    }

                    //Auwat Start  
                    var colorset_unit = [];
                    var colorset_unit_plan = [];
                    var colorset_unit_fill = [];

                    if (xtype == 'gap_closing') {
                        var datalg = $scope.listjobroles_gap;
                    } else {
                        var datalg = $scope.listjobroles_idp;
                    }
                    var icheck_list = 0;
                    var colorset_unit = [];
                    var colorset_unit_fill = [];
                    for (var i = 0; i < datalg.length; i++) {
                        if (datalg[i].STATUS == true) {
                            colorset_unit.push(datalg[i].COLOR);
                            colorset_unit_fill.push(datalg[i].COLOR);
                            colorset_unit_fill.push("#ffffff");
                            colorset_unit_plan.push("#ccc");
                            icheck_list++;
                        }
                    }

                    colorset_unit.push("#ffffff");
                    colorset_unit_fill.push("#ffffff");
                    colorset_unit_plan.push("#ffffff");
                    //Auwat End

                    if (type_name == "type") {

                        grid_def = {

                            yaxis: {
                                lines: {
                                    show: false
                                }
                            },
                            padding: {
                                top: 0,
                                right: 10,
                                bottom: 0,
                                left: 10

                            },
                        }
                        heightZ -= 20;

                        var Labels_offsetY = 5;
                        var data_type_select = $scope.arr_type_color;
                        var colorset_unit_fill = [];
                        data_type_select.forEach(function (d, s) {
                            dataseries.forEach(function (x, i) {
                                if (x.name == d.TYPE) {
                                    dataseries[i].sort_by = (s + 1);
                                    dataseries[i].color_j = d.COLOR;
                                    colorset_unit_fill.push(d.COLOR);
                                } else if (x.name.replace(" total", "") == d.TYPE) {
                                    dataseries[i].sort_by = (s + 1);
                                    dataseries[i].color_j = '#ccc';
                                    colorset_unit_fill.push('#FFFFFF');
                                }

                                for (var ik = 0; ik < datalg.length; ik++) {
                                    if (datalg[ik].NAME == x.name) {
                                        dataseries[i].color_j = datalg[ik].COLOR;
                                        break;
                                    } else if (datalg[ik].NAME == x.name.replace(" total", "")) {
                                        dataseries[i].color_j = "#CCC";
                                        break;
                                    }
                                }

                            });
                        });

                        dataseries.sort(function (a, b) { return a.sort_by - b.sort_by });
                        color_set = dataseries.map(function (d) { return d.color_j });
                        color_set.push('#FFFFFF');
                        colorset_unit_fill.push('#FFFFFF');
                    }
                    else if (type_name == 'unit') {

                        dataseries.forEach(function (x, i) {

                            if (x.name == 'EOSL') {
                                dataseries[i].sort_by = (1);
                                dataseries[i].color_j = colorset_unit[0];
                            }
                            else if (x.name == 'EOSL-A') { dataseries[i].sort_by = (2); dataseries[i].color_j = colorset_unit[1]; }
                            else if (x.name == 'EOSL-B') { dataseries[i].sort_by = (3); dataseries[i].color_j = colorset_unit[2]; }
                            else if (x.name == 'EOSL-C') { dataseries[i].sort_by = (4); dataseries[i].color_j = colorset_unit[3]; }
                            else if (x.name == 'EOSL-E') { dataseries[i].sort_by = (5); dataseries[i].color_j = colorset_unit[4]; }
                            else if (x.name == 'EOSL-F') { dataseries[i].sort_by = (6); dataseries[i].color_j = colorset_unit[5]; }
                            else if (x.name == 'EOSL total') {
                                dataseries[i].sort_by = (1);
                                dataseries[i].color_j = colorset_unit_plan[0];
                            }
                            else if (x.name == 'EOSL-A total') { dataseries[i].sort_by = (2); dataseries[i].color_j = colorset_unit_plan[1]; }
                            else if (x.name == 'EOSL-B total') { dataseries[i].sort_by = (3); dataseries[i].color_j = colorset_unit_plan[2]; }
                            else if (x.name == 'EOSL-C total') { dataseries[i].sort_by = (4); dataseries[i].color_j = colorset_unit_plan[3]; }
                            else if (x.name == 'EOSL-E total') { dataseries[i].sort_by = (5); dataseries[i].color_j = colorset_unit_plan[4]; }
                            else if (x.name == 'EOSL-F total') { dataseries[i].sort_by = (6); dataseries[i].color_j = colorset_unit_plan[5]; }

                            for (var ik = 0; ik < datalg.length; ik++) {
                                if (datalg[ik].NAME == x.name) {
                                    dataseries[i].color_j = datalg[ik].COLOR;
                                    break;
                                } else if (datalg[ik].NAME == x.name.replace(" total", "")) {
                                    dataseries[i].color_j = "#CCC";
                                    break;
                                }
                            }

                        });

                        dataseries.sort(function (a, b) { return a.sort_by - b.sort_by });
                        color_set = dataseries.map(function (d) { return d.color_j });
                        color_set.push('#FFFFFF');

                    }
                    else if (type_name == 'jobrole') {

                        //ข้อมูลที่ออกกราฟ 
                        dataseries.forEach(function (x, i) {
                            if (x.name == 'EOSL/5M') {
                                dataseries[i].sort_by = (1);
                                dataseries[i].color_j = colorset_unit[0];
                            }
                            else if (x.name == 'Senior') { dataseries[i].sort_by = (3); dataseries[i].color_j = colorset_unit[1]; }
                            else if (x.name == 'Supervisor') { dataseries[i].sort_by = (4); dataseries[i].color_j = colorset_unit[2]; }
                            else if (x.name == 'Junior') { dataseries[i].sort_by = (5); dataseries[i].color_j = colorset_unit[3]; }
                            else if (x.name == 'EOSL/5M total') {

                                dataseries[i].sort_by = (1);
                                dataseries[i].color_j = colorset_unit_plan[0];
                            }
                            else if (x.name == 'Senior total') { dataseries[i].sort_by = (3); dataseries[i].color_j = colorset_unit_plan[1]; }
                            else if (x.name == 'Supervisor total') { dataseries[i].sort_by = (4); dataseries[i].color_j = colorset_unit_plan[2]; }
                            else if (x.name == 'Junior total') { dataseries[i].sort_by = (5); dataseries[i].color_j = colorset_unit_plan[3]; }

                            for (var ik = 0; ik < datalg.length; ik++) {
                                if (datalg[ik].NAME == x.name) {
                                    dataseries[i].color_j = datalg[ik].COLOR;
                                    break;
                                } else if (datalg[ik].NAME == x.name.replace(" total", "")) {
                                    dataseries[i].color_j = "#CCC";
                                    break;
                                }
                            }

                        });

                        dataseries.sort(function (a, b) { return a.sort_by - b.sort_by });
                        color_set = dataseries.map(function (d) { return d.color_j });
                        color_set.push('#FFFFFF');
                    }

                    var c_yoffset = 0;
                    //dataseries.push({
                    //    name: ""
                    //    , data: Array(12).fill(20)
                    //    , stype: ""
                    //    , xtotal: 0
                    //});

                    //Auwat 20200522 1300 
                    console.log("dataseries");
                    console.log(dataseries);

                    var color_set = [];
                    var colorset_unit_fill = [];
                    var dataseries_copy = [];
                    var dataseries_copy_total = [];
                    for (var i = 0; i < dataseries.length; i++) {
                        if (dataseries[i].name.indexOf(" total") > -1) {
                            if (dataseries_copy_total.length == 0) {
                                dataseries_copy_total.push(angular.copy(dataseries[i]));
                                dataseries_copy_total[0].sort_by = 99;
                                dataseries_copy_total[0].name = "Total";
                            } else {
                                dataseries_copy_total[0].sort_by = 99;
                                dataseries_copy_total[0].name = "Total";
                                for (var j = 0; j < 12; j++) {
                                    dataseries_copy_total[0].data[j] += +dataseries[i].data[j];
                                }
                            }
                        } else if (dataseries[i].name == null) {

                        } else {
                            dataseries_copy.push(angular.copy(dataseries[i]));
                        }
                    }
                    var dataseries = dataseries_copy;
                    dataseries.push(angular.copy(dataseries_copy_total[0]));
                    dataseries.sort(function (a, b) { return a.sort_by - b.sort_by });
                    color_set = dataseries.map(function (d) { return d.color_j });
                    color_set.push('#FFFFFF');

                    colorset_unit_fill.push(angular.copy(color_set));
                    dataseries.push({
                        name: ""
                        , data: Array(12).fill(20)
                        , stype: ""
                        , xtotal: 0
                    });

                    console.log("dataseries copy");
                    console.log(dataseries);


                }

                if (type_number == 4) {
                    //กรณี AGAINT PLAN BY JOB ROLE
                    var xcolumnWidth = '50%'
                    var data_d = $scope.idp_by_jobroles;
                    var data_x = get_data_binde_chart(data_d, xtype);

                    var tick_amount = 5;
                    var c_yoffset = 20;
                    grid_def = {

                        yaxis: {
                            lines: {
                                show: true
                            }
                        },
                        padding: {
                            top: -26,
                            right: 10,
                            bottom: -5,
                            left: 10
                        },
                    }
                    var max = 100
                    var xoffsetY = -15;
                    var distributed = true;

                    xtextXaix = ['Manager', 'Senior', 'Supervisor', 'Junior'];
                    xtextXaix = ['EOSL/5M', 'Senior', 'Supervisor', 'Junior'];

                    //sumtotal  
                    var data_d = data_x.map(function (d, i) {
                        var role = xtextXaix[i];
                        var total = $scope.idp_by_jobroles.filter(function (d) { return d.BY_TYPE_NAME == role }).reduce(function (a, b) {
                            return (a + b.PLANS_COMPLETE)
                        }, 0);
                        var push_d = (d / total) * 100;
                        return +push_d.toFixed(0)
                    });

                    color_set = ['#2494CC', '#00E396', '#FEB019', '#FF4560'];

                    var dataseries = [{
                        name: "Completed",
                        xtotal: total,
                        data: data_d
                    }];

                    heightZ = "412";

                    istack = false;
                }

                var options = {
                    series: dataseries,
                    chart: {
                        events: {
                            click: function (event, chartContext, config) {
                            }
                        },
                        height: heightZ,
                        type: 'bar',
                        toolbar: {
                            show: false,
                        },
                        offsetX: -10,
                        offsetY: c_yoffset,

                        stacked: istack,
                        sparkline: {
                            enabled: false,
                        },
                        events: {

                            legendClick: function (chartContext, seriesIndex, config) {

                            }

                        }
                    },

                    plotOptions: {
                        bar: {
                            columnWidth: xcolumnWidth,
                            distributed: distributed,
                            dataLabels: {
                                position: 'top'
                            },
                        }
                    },
                    colors: color_set,
                    dataLabels: {
                        enabled: true,
                        position: 'top',
                        offsetY: Labels_offsetY,
                        offsetX: 0,

                        formatter: function (val, opts) {

                            var sindex = opts.seriesIndex;//type = role
                            var total = opts.w.config.series[0].xtotal;
                            var dindex = opts.dataPointIndex;
                            var serise = opts.w.globals.series;

                            if (type_number == 1) {

                                var len_serise = serise.length - 1;
                                if (opts.seriesIndex != len_serise) { return ""; }

                                //function แบบเดียวกันกับ tooltip
                                var sindex = opts.seriesIndex;
                                var dindex = opts.dataPointIndex;
                                var serise = opts.series;

                                try {

                                    if (opts.w.config.series[0].stype == 'againt_plan' || opts.w.config.series[0].stype == 'gap_closing') {
                                        if (opts.w.config.series[0].stype == 'againt_plan') {
                                            $scope.data_tooltip = $scope.data_tooltip_again;
                                        }
                                        else {
                                            $scope.data_tooltip = $scope.data_tooltip_gap;
                                        }
                                        var data_xs = data_x.find(function (d, i, s) { return i == sindex });
                                        //ยอดcomplate 
                                        var total_complate_month = $scope.data_tooltip.filter(function (m) { return m.MONTH == (dindex + 1) }).reduce(function (a, b) { return a + b.VALUES_COMPLETE }, 0);
                                        //total ทั้งเดือน
                                        var total_plan_all = $scope.data_tooltip.filter(function (d) { return d.MONTH == (dindex + 1) }).reduce(function (a, b) { return a + b.PLANS_COMPLETE }, 0);
                                        var percent_total = ((total_complate_month / total_plan_all) * 100).toFixed(0);

                                        if (percent_total.replace("NaN", "") == "") { return ""; } else { return percent_total.replace("NaN", "") + "%"; }

                                    }

                                } catch{ return ""; }
                                return "";
                            }
                            else {
                                val = val.toFixed(0);
                                if (val == 100) {
                                    val = '';
                                }
                                else {
                                    if (val != '') {
                                        if (val == 0) {
                                            val = '';
                                        }
                                        else {

                                            val = val + "%";
                                        }
                                    }

                                }
                            }


                            return val;
                        },

                        style: {
                            colors: ['#000'],
                            fontSize: '8px',
                            fontFamily: 'Montserrat, sans-serif',
                        },

                    },

                    xaxis: {
                        labels: {
                            rotate: -45
                        },
                        axisTicks: {
                            show: false,
                        },
                        categories: xtextXaix,
                        labels: {
                            show: true,
                            style: {
                                colors: '#5E5F5E',
                                fontSize: '10px',
                                fontFamily: 'Montserrat, sans-serif',
                            }
                        },
                    },
                    yaxis: {

                        axisBorder: {
                            show: false,
                        },
                        axisTicks: {
                            show: false,
                            color: '#78909C',
                        },

                        crosshairs: {
                            show: false,
                        },

                        tickAmount: tick_amount,
                        min: 0,
                        max: xmax,

                        labels: {
                            show: true,
                            align: 'right',
                            //minWidth: 0,
                            //maxWidth: 100,
                            style: {
                                color: '#5E5F5E',
                                fontSize: '8px',
                                //fontFamily: 'Helvetica, Arial, sans-serif',
                                fontFamily: 'sans-serif',
                                cssClass: 'apexcharts-yaxis-label',
                            },
                            offsetX: 0,
                            offsetY: 0,
                            rotate: 0,

                            formatter: function (value) {
                                var xvalue = value.toFixed(0);
                                if (type_number == 1) {

                                    return xvalue + " %";
                                }
                                else {
                                    return xvalue + " %"
                                }
                            },
                        },

                    },
                    grid: grid_def,
                    legend: {
                        position: set_position,
                        show: false,
                        markers: {
                            fillColors: colorset_unit_fill

                        },
                        formatter: function (seriesName, opts) {
                            if (seriesName.indexOf('total') > -1) {
                                return ''
                            }
                            return [seriesName]
                        },
                        position: 'bottom',
                        horizontalAlign: 'center',
                        offsetY: -10,
                    },
                    tooltip: {
                        shared: false,
                        y: {
                            formatter: function (val, opts) {
                                try {
                                    var sindex = opts.seriesIndex; // ตำแน่งของ role
                                    var total = opts.w.config.series[0].xtotal;//ยอดรวมทั้งกราฟ plan
                                    var dindex = opts.dataPointIndex;// ตำแน่งของ เดือน
                                    var serise = opts.series;

                                    //ค่า actual = 8 จากทั้งหมดของแท่งนั้น = 262  คิดเป็น 3 % // ค่าของ plan ในเดือนนั่น
                                    //แล้ว total ค่า actual = 8 จากทั้งหมดของทั้งหมด = 361  คิดเป็น 2 % าของ plan ในเดือนนั่น 

                                    var text = '';
                                    if (opts.w.config.series[0].stype == 'againt_plan' || opts.w.config.series[0].stype == 'gap_closing') {


                                        try {
                                            if (opts.w.config.series[sindex].name.indexOf(" total") > -1) {
                                                sindex -= 1;
                                            }

                                            if (opts.w.config.series[0].stype == 'againt_plan') {
                                                $scope.data_tooltip = $scope.data_tooltip_again;
                                            }
                                            else {
                                                $scope.data_tooltip = $scope.data_tooltip_gap;
                                            }

                                            var data_xs = dataseries.find(function (d, i, s) { return i == sindex });
                                            if (data_xs.name == "") {
                                                return text;
                                            }
                                            console.log("data_xs.name:" + data_xs.name + " ***MONTH:" + dindex);
                                            console.log($scope.data_tooltip);

                                            var data_d = $scope.data_tooltip.filter(function (d) { return d.TYPE_CODE == data_xs.name });
                                            var data_plan = $scope.data_tooltip.filter(function (d) { return d.MONTH == (dindex + 1) });
                                            var val_by_dataset = data_d.filter(function (d) { return d.MONTH == (dindex + 1) });

                                            var val_by_month = 0;
                                            try {
                                                val_by_month = val_by_dataset[0].VALUES_COMPLETE == null ? 0 : val_by_dataset[0].VALUES_COMPLETE;
                                            } catch{ }

                                            //ยอดcomplate
                                            total_complate = data_d.reduce(function (a, b) { return a + b.VALUES_COMPLETE }, 0);

                                            var total_plan_all = data_plan.reduce(function (a, b) { return a + b.PLANS_COMPLETE }, 0);
                                            var total_plan_month = val_by_dataset.filter(function (m) { return m.VALUES_COMPLETE != null }).reduce(function (a, b) { return a + b.PLANS_COMPLETE }, 0);

                                            var percent_actual = (val_by_month / total_plan_month) * 100;
                                            var percent_total = (val_by_month / total_plan_all) * 100;

                                            if (data_xs.name == "Total") {
                                                total_plan_month = ($scope.data_tooltip.filter(function (d) { return d.MONTH == (dindex + 1) })).filter(function (m) { return m.PLANS_COMPLETE != null }).reduce(function (a, b) { return a + b.PLANS_COMPLETE }, 0);
                                                text = "" + total_plan_month + " ";
                                            } else {
                                                if (icheck_list == 1) {
                                                    text = "Actual: " + (percent_actual.toFixed(0) + "% ").replace("NaN%", "0%") + "(" + val_by_month + "/" + total_plan_month + ")";
                                                } else {

                                                    text = "Actual: " + (percent_actual.toFixed(0) + "% ").replace("NaN%", "0%") + "(" + val_by_month + "/" + total_plan_month + ") Total: " + percent_total.toFixed(0) + "% (" + val_by_month + "/" + total_plan_all + ")";
                                                }
                                            }


                                        } catch (ex) {

                                            return ex;
                                        }
                                    }
                                    else {

                                        if ("IDP COMPLETION BY EMPLOYEE CATAGORIES" == "IDP COMPLETION BY EMPLOYEE CATAGORIES") {
                                            var data_serise = xtextXaix;
                                            var n_jobrole = data_serise[dindex];
                                            //DATA BY JOBROLE
                                            var d_select_jobrole = $scope.data_tooltip_jobrole;
                                            //alert(n_jobrole);
                                            //TOTAL PLAN
                                            var total = opts.w.config.series[0].xtotal;
                                            //COMPLETE BY ROLE
                                            var total_complete = d_select_jobrole.filter(function (d) { return d.BY_TYPE_NAME == n_jobrole }).reduce(function (a, b) { return a + b.VALUES_COMPLETE }, 0);
                                            var total_by_role = d_select_jobrole.filter(function (d) { return d.BY_TYPE_NAME == n_jobrole }).reduce(function (a, b) { return a + b.PLANS_COMPLETE }, 0);
                                            //var actual = ((val * total) / 100).toFixed(0);

                                            var actual = total_complete;

                                            var percent_actual = (actual / actual) * 100;
                                            var percent_total = (actual / total_by_role) * 100;

                                            text = "Actual:" + percent_total.toFixed(0) + "% (" + actual + "/" + total_by_role + ")";
                                        }

                                    }

                                    return text;

                                } catch{ return "Plan :" + val; }
                            }
                        },
                        x: {
                            show: true,
                            formatter: function (val, opts) {

                                try {
                                    var sindex = opts.seriesIndex;
                                    var total = opts.w.config.series[0].xtotal;
                                    var dindex = opts.dataPointIndex;
                                    var serise = opts.series;
                                    var actual = serise[sindex][dindex];
                                    var tofmonth = 0;
                                    var result = val;
                                    if (opts.w.config.series[0].stype == 'againt_plan' || opts.w.config.series[0].stype == 'gap_closing') {
                                        if (opts.w.config.series[0].stype == 'againt_plan') {
                                            $scope.data_tooltip = $scope.data_tooltip_again;
                                        }
                                        else {
                                            $scope.data_tooltip = $scope.data_tooltip_gap;
                                        }
                                        var data_xs = data_x.find(function (d, i, s) { return i == sindex });

                                        var data_d = $scope.data_tooltip.filter(function (d) { return d.TYPE_CODE == data_xs.name });
                                        var data_plan = $scope.data_tooltip.filter(function (d) { return d.MONTH == (dindex + 1) });

                                        //ยอดcomplate
                                        total_complate = data_d.reduce(function (a, b) { return a + b.VALUES_COMPLETE }, 0);
                                        var total_complate_month = $scope.data_tooltip.filter(function (m) { return m.MONTH == (dindex + 1) }).reduce(function (a, b) { return a + b.VALUES_COMPLETE }, 0);
                                        //total ทั้งเดือน
                                        var total_plan_all = $scope.data_tooltip.filter(function (d) { return d.MONTH == (dindex + 1) }).reduce(function (a, b) { return a + b.PLANS_COMPLETE }, 0);
                                        var percent_total = ((total_complate_month / total_plan_all) * 100).toFixed(0);

                                        if (percent_total.replace("NaN", "") == "") { percent_total = ""; } else {
                                            percent_total = percent_total + '%'
                                        }

                                        return result = val + ' : ' + percent_total + ' (' + total_complate_month + '/' + total_plan_all + ')';

                                    }
                                    return result;

                                } catch{ return "Plan :" + val; }
                            }
                        },
                    },
                    labels: ['Plan', 'Completed']
                };

                var chart = new ApexCharts(document.querySelector("#" + chart_name), options);
                chart.render();

                $(window).on("resize", function () { }).resize();

            }



            $scope.pfd_print = function screenshot() {

                document.getElementById("css_div_idp_left").className = "border_print";
                document.getElementById("css_div_idp_center").className = "border_print";
                document.getElementById("css_div_idp_right").className = "border_print";
                document.getElementById("css_div_idp_bottom").className = "border_print";

                var HTML_Width = $(".canvas_div_pdf").width();
                var HTML_Height = $(".canvas_div_pdf").height();
                var top_left_margin = 1;
                var PDF_Width = HTML_Width + (top_left_margin * 2);
                var PDF_Height = (PDF_Width * 1.5) + (top_left_margin * 2);
                var canvas_image_width = HTML_Width;
                var canvas_image_height = HTML_Height;

                var icount_def = 0;
                var HTML_Width_Def = 4961;
                var HTML_Height_Def = 3508;
                for (var i = 1; i < 10; i++) {
                    if ((HTML_Width * i) > HTML_Width_Def) {
                        if (i != 1) {
                            HTML_Width = (HTML_Width * i - 1);
                            HTML_Height = (HTML_Height * i - 1);
                            icount_def = i;
                        }
                        break;
                    }
                }

                PDF_Width = HTML_Width;
                PDF_Height = HTML_Height;

                canvas_image_width = HTML_Width - 100;
                canvas_image_height = HTML_Height - 100;

                var HTML_Width_Header = PDF_Width;
                var checkw_window = $(window).width();


                if (checkw_window == 1269) {
                    var HTML_Width_Def = $(".canvas_div_pdf").width();
                    var HTML_Height_Def = $(".canvas_div_pdf").height();
                    canvas_image_width = (HTML_Width_Def * (icount_def - 0.01));
                    canvas_image_height = (HTML_Height_Def * (icount_def));
                    HTML_Width_Header = canvas_image_width;
                }
                if (checkw_window == 1707) {

                    var HTML_Width_Def = $(".canvas_div_pdf").width();
                    var HTML_Height_Def = $(".canvas_div_pdf").height();
                    canvas_image_width = (HTML_Width_Def * (icount_def - 0.15));
                    canvas_image_height = (HTML_Height_Def * (icount_def));
                    HTML_Width_Header = canvas_image_width;
                }
                if (checkw_window == 1730) {

                    var HTML_Width_Def = $(".canvas_div_pdf").width();
                    var HTML_Height_Def = $(".canvas_div_pdf").height();
                    canvas_image_width = (HTML_Width_Def * (icount_def - 0.3));
                    canvas_image_height = (HTML_Height_Def * (icount_def));
                    HTML_Width_Header = canvas_image_width;
                }
                if (checkw_window > 1900) {

                    var HTML_Width_Def = $(".canvas_div_pdf").width();
                    var HTML_Height_Def = $(".canvas_div_pdf").height();
                    canvas_image_width = (HTML_Width_Def * (icount_def - 0.54));
                    canvas_image_height = (HTML_Height_Def * (icount_def + 0.5));
                    HTML_Width_Header = canvas_image_width;
                }

                var totalPDFPages = Math.ceil(HTML_Height / PDF_Height) - 1;

                html2canvas(document.querySelector("#divPage")).then(canvas = function (canvas) {

                    canvas.getContext('2d');
                    canvas.font = 'bold 48px Times New Roman 12pt';
                    var imgData = canvas.toDataURL("image/jpeg", 1.0);
                    $scope.ImgDataS = imgData;


                    var pdf = new jsPDF('l', 'pt', [PDF_Width, PDF_Height]);
                    pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin - 0, canvas_image_width, canvas_image_height);

                    if (totalPDFPages <= 1) {

                        var today = moment().format('LLLL');//new Date();
                        var newdat = "Date Printed : " + today;
                        var newdat2 = "Print From EOSL Dashboard System";
                        pdf.setFont("courier");
                        pdf.setFontSize(50);


                        if (checkw_window == 1980) {
                            pdf.text(newdat, HTML_Width_Header * 0.70, 80);

                            //pdf.text(HTML_Width * 0.8, PDF_Height - 30, newdat2);
                            pdf.text(newdat2, HTML_Width_Header * 0.70, 40);
                        }
                        else {

                            pdf.text(newdat, HTML_Width_Header * 0.70, 80);

                            //pdf.text(HTML_Width * 0.8, PDF_Height - 30, newdat2);
                            pdf.text(newdat2, HTML_Width_Header * 0.70, 40);
                        }
                    }
                    for (var i = 1; i <= totalPDFPages; i++) {
                        pdf.addPage(PDF_Width, PDF_Height);
                        pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height * i) + (top_left_margin * 4), canvas_image_width, canvas_image_height);

                    }
                    pdf.save("EOSL_DASHBOARD_" + momentNow.format('YYYYMMDDHHMMSS') + ".pdf");
                    $("#divLoading").hide();

                    document.getElementById("css_div_idp_left").className = "card box-shadow-1 mb-0";
                    document.getElementById("css_div_idp_center").className = "card box-shadow-1 mb-1";
                    document.getElementById("css_div_idp_right").className = "card box-shadow-1 mb-0";
                    document.getElementById("css_div_idp_bottom").className = "card box-shadow-1";

                });
            }




        });


    </script>
</asp:Content>
