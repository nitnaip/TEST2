<%@ Page Title="" Language="C#" MasterPageFile="~/web/MasterPageTopMenu.master" AutoEventWireup="true" CodeFile="idp_by_employees.aspx.cs" Inherits="web_idp_by_employees" %>

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

        .overlayx:hover {
            background: #ECEFF1;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <a id="btnToTop" data-toggle="tooltip" data-placement="top" title="" data-original-title="Go to top"></a>
    <div id="divPage" class="app-content content canvas_div_pdf" data-ng-app="app" data-ng-controller="ctrlApp">
        <%--bg-blue-grey bg-darken-4--%>
        <div class="content-wrapper pb-0 mb-0">

            <div class="content-header row">
                <div class="col-xl-8 col-lg-8 col-md-12 col-12">
                    <h4 class="content-header-title mb-0">{{YEAR_SIMPLE}}</h4>
                    <div class="breadcrumb-wrapper col-12 ml-0 pl-0">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="portal.aspx">HOME</a>
                            </li>
                            <li class="breadcrumb-item active"><a href="IDP_by_unit.aspx?year={{year_select}}">IDP BY EOSL</a>
                            </li>
                            <li class="breadcrumb-item active"><a href="IDP_by_team.aspx?unit_name={{unit_code_select}}&team_name=&year={{year_select}}">IDP BY {{unit_code_select}}  </a>
                            </li>
                            <li class="breadcrumb-item">IDP BY {{team_code_select}}   
                            </li>
                        </ol>
                    </div>
                </div>


                <div class="col-xl-4 col-lg-x`4 col-md-12 col-12 pt-1">
                    <a data-html2canvas-ignore="false" data-ng-click="pfd_print()"
                        class="float-right btn btn-social  btn-xs btn-outline-danger float-r  bg-danger  white "
                        style="height: 28px;"><span class="fa fa-file-pdf-o"></span>generate PDF</a>

                    <select data-html2canvas-ignore="false" class="form-control w-auto bg-white  mr-0  mb-0 float-right mr-2 pr-2" style="height: 28px; background-color: transparent; position: relative; z-index: 100; height: 28px"
                        data-ng-change="swich_year(year_select)" data-ng-model="year_select">
                        <option value="">All</option>
                        <option value="{{dt.CODE}}" data-ng-repeat="dt in dtyear">{{dt.NAME}}</option>

                    </select>

                </div>


            </div>

            <div class="content-body">

                <div class="row match-height">
                    <div class="col-xl-3 col-lg-6 col-12 {{arr_div_box_css[$index]}}"
                        data-ng-repeat="dt in dtidp_totals">
                        <div class="card box-shadow-1 mb-1" data-ng-style="{'background-color':arr_css[$index]}">
                            <div class="card-header pb-0 mb-0 card_mp_t" data-ng-style="{'background-color':arr_css[$index]}">
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
                                        <span data-ng-if="dt.PLANS_COMPLETE != null">Total {{dt.PLANS_COMPLETE}}</span>
                                    </div>
                                    <div class="media-body white text-right">
                                        <span>Completed</span>
                                        <span data-ng-if="dt.VALUES_COMPLETE == null">N/A</span>
                                        <span data-ng-if="dt.VALUES_COMPLETE != null">{{dt.VALUES_COMPLETE}}</span>
                                    </div>
                                </div>
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

                <div class="row match-height">

                    <div class="col-xl-3 col-lg-3 col-md-12 col-sm-12  pr-xl-0 pr-lg-0 mb-sm-1">
                        <div class="card box-shadow-1 mb-0" id="css_div_idp_left">

                            <div class="card-header pb-0 mb-0">
                                <h6 class=" text-uppercase font-weight-bold"><i class="fa fa-address-book-o" aria-hidden="true"></i>&#32;{{text_COMPETENCY}}</h6>
                            </div>

                            <div class="card-body">
                                <div class="row col-12 m-0 p-0">
                                    <div class="col-12">
                                        <div class="row m-0 p-0 px-0">
                                            <div class="col-6 m-0 p-0 text-left">
                                                <span class="text-left font-italic font-large-1">{{complete_idp == null ? '0' : complete_idp }}</span><br />
                                                <span class="text-left font-italic font-small-2"><i class="ft-circle bg-warning rounded-circle text-warning font-small-2 mr-0" style="height: 12px"></i>&#32;Completed</span>
                                            </div>
                                            <div class="col-6 m-0 p-0 text-right">
                                                <span class="text-right font-italic font-large-1">{{plan_idp == null ? '0' : plan_idp}}</span><br />
                                                <span class="text-right font-italic font-small-3">Total</span>
                                            </div>
                                            <div id="chart_pie_staff_deverlopment" class="height-300  w-100 m-0 p-0 mt-xl-1 mr-0"></div>

                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="col-xl-4 col-lg-4 col-md-12 col-sm-12 pr-0">
                        <div class="card box-shadow-1 mb-1" id="css_div_idp_center">
                            <div class="card-header pb-0 mb-0">
                                <h6 class=" text-uppercase font-weight-bold text-nowrap">{{text_IDP_BY_JONROLE}}</h6>

                            </div>
                            <div class="card-body pt-0 mt-0 pb-0">
                                <div id="chart_idp" class="w-100"></div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-5 col-lg-5 col-md-12 col-sm-12 ">

                        <div class="card box-shadow-1 mb-0" id="css_div_idp_right">
                            <div class="card-body px-0 mt-0 pb-0">
                                <div class="card-header pt-0 pb-0 mb-0">
                                    <label class="font-small-3 text-uppercase font-weight-bold">{{text_IDP}}</label>

                                    <select class="form-control form-control-sm form-control block float-right" style="width: 100%; width: 200px; height: 28px"
                                        id="ddlidp_chart_type" data-ng-model="idp_chart_type" data-ng-change="on_change_idp_type()">
                                        <option value="type">By Type</option>
                                        <option value="jobrole">By Employee catagories</option>
                                        <option value="staff">By Staff</option>
                                    </select>
                                </div>

                                <div id="chart_idp_plan" class="w-100 m-0 p-0"></div>

                                <div data-ng-if="idp_chart_type != 'jobrole'" class="form-group align-self-center m-0 p-0" style="height: 40px; overflow: auto">
                                    <div class="custom-control custom-checkbox float-left" data-ng-repeat="dt in listjobroles_idp">
                                        <b class="btn font-size-small m-0 p-0 " style="width: 12px; height: 12px;"
                                            data-ng-click="swich_type_chart_idp(dt.NAME,dt.STATUS)"
                                            data-ng-style="{'background-color':(dt.STATUS== true?dt.COLOR:'#CCC')}"></b><small>&nbsp{{idp_chart_type == 'staff'?dt.SHORT_NAME : dt.NAME}} </small>
                                    </div>
                                </div>

                                <center data-ng-if="idp_chart_type == 'jobrole'">
                                <div class="form-check-inline" style="height: 40px; overflow: auto">  
                                    <div class="custom-control custom-checkbox float-left" data-ng-repeat="dt in listjobroles_idp">
                                        <b class="btn font-size-small m-0 p-0 " style="width: 12px; height: 12px;"
                                            data-ng-click="swich_type_chart_idp(dt.NAME,dt.STATUS)"
                                            data-ng-style="{'background-color':(dt.STATUS== true?dt.COLOR:'#CCC')}"></b><small>&nbsp{{idp_chart_type == 'staff'?dt.SHORT_NAME : dt.NAME}} </small>
                                    </div>
                                </div>
                               </center>

                                <div class="card-header pb-0 mb-0">
                                    <label class=" text-uppercase font-weight-bold">{{text_GAP}}</label>
                                </div>
                                <div id="chart_gap_plan" class="align-self-center w-100 m-0 p-0"></div>

                                <div data-ng-if="idp_chart_type != 'jobrole'" class="form-group m-0 p-0" style="height: 40px; overflow: auto">
                                    <div class="custom-control custom-checkbox float-left" data-ng-repeat="dt in listjobroles_gap">
                                        <b class="btn font-size-small m-0 p-0 " style="width: 12px; height: 12px;"
                                            data-ng-click="swich_type_chart_gap(dt.NAME,dt.STATUS)"
                                            data-ng-style="{'background-color':(dt.STATUS== true?dt.COLOR:'#CCC')}"></b><small>&nbsp{{idp_chart_type == 'staff'?dt.SHORT_NAME : dt.NAME}} </small>
                                    </div>
                                </div>
                                <center data-ng-if="idp_chart_type == 'jobrole'">
                                <div class="form-check-inline" style="height: 40px; overflow: auto"> 

                                    <div class="custom-control custom-checkbox float-left" data-ng-repeat="dt in listjobroles_gap">
                                        <b class="btn font-size-small m-0 p-0 " style="width: 12px; height: 12px;"
                                            data-ng-click="swich_type_chart_gap(dt.NAME,dt.STATUS)"
                                            data-ng-style="{'background-color':(dt.STATUS== true?dt.COLOR:'#CCC')}"></b><small>&nbsp{{idp_chart_type == 'staff'?dt.SHORT_NAME : dt.NAME}} </small>
                                    </div> 
                                </div>
                               </center>

                            </div>
                        </div>
                    </div>

                </div>


                <div class="row  match-height">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-12">
                        <div class="card box-shadow-1 mb-0" id="css_div_idp_bottom">

                            <div class="card-header">
                                <h6 class="text-uppercase font-weight-bold">{{text_type}}</h6>
                                <a class="heading-elements-toggle"><i class="fa fa-ellipsis-v font-medium-3"></i></a>
                                <div class="heading-elements">
                                </div>
                            </div>

                            <div class="carxd-body px-1 pt-0 mt-0">
                                <div id="goal-list-scroll" class="table-responsive height-300 position-relative ps-container ps-theme-default ps-active-y mb-0 px-2 overflow-auto">

                                    <div class="row">

                                        <a class="list-group-item col-xl-4 col-sm-12 overlayx" data-ng-repeat="dt in idp_overall_staffs_new | orderBy :'ICOL' " data-ng-if="dt.IROW == 1"
                                            data-ng-click="on_click_next(team_code_select,dt.STAFF_NAME,dt.OWNERID);"
                                            title="EMP_GROUP_SORT: {{dt.EMP_GROUP_SORT}} --  EMP_SORT: {{dt.EMP_SORT}} --  ICOL: {{dt.ICOL}} --IROW : {{dt.IROW}}">
                                            <div class="media  cursor-pointer ">
                                                <div class="media-left pr-1">
                                                    <span class="avatar avatar-sm avatar-online rounded-circle">
                                                        <img src="{{dt.STAFF_IMG}}" /><i></i></span>
                                                </div>
                                                <div class="media-body ">
                                                    <div class="row justify-content-end">
                                                        <div class="col-6 d-flex flex-column justify-content-center">
                                                            <%--<small>EMP_GROUP_SORT: {{dt.EMP_GROUP_SORT}} --  EMP_SORT: {{dt.EMP_SORT}} --  ICOL: {{dt.ICOL}} --IROW : {{dt.IROW}}</small>--%>
                                                            <h6 class="media-heading mb-0 font-small-3">{{dt.STAFF_NAME}}</h6>
                                                            <span class=" mb-0 text-muted font-italic  " style="font-size: 0.60rem;">{{dt.STAFF_DESC}}</span>
                                                            <span data-ng-show="(emp_id == dt.OWNERID || emp_approver == true || emp_teamheader == true ||  emp_admin == true) && (dt.PLANS_COMPLETE==null?0:dt.PLANS_COMPLETE >0)" class="success font-small-2 mt-0">See detail&#32;<i class="fa fa-long-arrow-right" aria-hidden="true"></i></span>
                                                       
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="row justify-content-lg-end">

                                                                <div class="flex-grow-0 d-flex flex-column justify-content-center mr-1">
                                                                    <span class=" text-black text-center font-medium-1 font-weight-bold d-flex justify-content-center">{{((dt.VALUES_COMPLETE == null) ? 0 :dt.VALUES_COMPLETE /dt.PLANS_COMPLETE)*100 | number:0}}%</span>
                                                                    <span class="  text-black text-center font-weight-normal success  d-flex justify-content-center pl-0 font-small-1">{{(dt.VALUES_COMPLETE == null) ? 0 :dt.VALUES_COMPLETE}} / {{dt.PLANS_COMPLETE}}</span>
                                                                    <span class="  text-black text-center font-weight-normal d-flex justify-content-center pl-0 font-small-1">Completed/Total</span>
                                                                </div>

                                                            </div>

                                                        </div>


                                                    </div>
                                                </div>
                                            </div>

                                        </a>
                                    </div>
                                    <div class="row">

                                        <a class="list-group-item col-xl-4 col-sm-12 overlayx" data-ng-repeat="dt in idp_overall_staffs_new | orderBy :'ICOL' " data-ng-if="dt.IROW == 2"
                                            data-ng-click="on_click_next(team_code_select,dt.STAFF_NAME,dt.OWNERID);"
                                            title="EMP_GROUP_SORT: {{dt.EMP_GROUP_SORT}} --  EMP_SORT: {{dt.EMP_SORT}} --  ICOL: {{dt.ICOL}} --IROW : {{dt.IROW}}">
                                            <div class="media  cursor-pointer">
                                                <div class="media-left pr-1">
                                                    <span class="avatar avatar-sm avatar-online rounded-circle">
                                                        <img src="{{dt.STAFF_IMG}}" /><i></i></span>
                                                </div>
                                                <div class="media-body ">
                                                    <div class="row justify-content-end">
                                                        <div class="col-6 d-flex flex-column justify-content-center">
                                                            <%--<small>EMP_GROUP_SORT: {{dt.EMP_GROUP_SORT}} --  EMP_SORT: {{dt.EMP_SORT}} --  ICOL: {{dt.ICOL}} --IROW : {{dt.IROW}}</small>--%>

                                                            <h6 class="media-heading mb-0 font-small-3">{{dt.STAFF_NAME}}</h6>
                                                            <span class=" mb-0 text-muted font-italic  " style="font-size: 0.60rem;">{{dt.STAFF_DESC}}</span>
                                                            <span data-ng-show="(emp_id == dt.OWNERID || emp_approver == true || emp_teamheader == true ||  emp_admin == true) && (dt.PLANS_COMPLETE==null?0:dt.PLANS_COMPLETE >0)" class="success font-small-2 mt-0">See detail&#32;<i class="fa fa-long-arrow-right" aria-hidden="true"></i></span>

                                                        </div>
                                                        <div class="col-6">
                                                            <div class="row justify-content-lg-end">

                                                                <div class="flex-grow-0 d-flex flex-column justify-content-center mr-1">
                                                                    <span class=" text-black text-center font-medium-1 font-weight-bold d-flex justify-content-center">{{((dt.VALUES_COMPLETE == null) ? 0 :dt.VALUES_COMPLETE /dt.PLANS_COMPLETE)*100 | number:0}}%</span>
                                                                    <span class="  text-black text-center font-weight-normal success  d-flex justify-content-center pl-0 font-small-1">{{(dt.VALUES_COMPLETE == null) ? 0 :dt.VALUES_COMPLETE}} / {{dt.PLANS_COMPLETE}}</span>
                                                                    <span class="  text-black text-center font-weight-normal d-flex justify-content-center pl-0 font-small-1">Completed/Total</span>
                                                                </div>

                                                            </div>

                                                        </div>


                                                    </div>
                                                </div>
                                            </div>

                                        </a>
                                    </div>
                                    <div class="row">
                                        <a class="list-group-item col-xl-4 col-sm-12 overlayx" data-ng-repeat="dt in idp_overall_staffs_new | orderBy :'ICOL' " data-ng-if="dt.IROW == 3"
                                            data-ng-click="on_click_next(team_code_select,dt.STAFF_NAME,dt.OWNERID);"
                                            title="EMP_GROUP_SORT: {{dt.EMP_GROUP_SORT}} --  EMP_SORT: {{dt.EMP_SORT}} --  ICOL: {{dt.ICOL}} --IROW : {{dt.IROW}}">

                                            <div class="media  cursor-pointer">
                                                <div class="media-left pr-1">
                                                    <span class="avatar avatar-sm avatar-online rounded-circle">
                                                        <img src="{{dt.STAFF_IMG}}" /><i></i></span>
                                                </div>
                                                <div class="media-body ">
                                                    <div class="row justify-content-end">
                                                        <div class="col-6 d-flex flex-column justify-content-center">
                                                            <%--<small>EMP_GROUP_SORT: {{dt.EMP_GROUP_SORT}} --  EMP_SORT: {{dt.EMP_SORT}} --  ICOL: {{dt.ICOL}} --IROW : {{dt.IROW}}</small>--%>

                                                            <h6 class="media-heading mb-0 font-small-3">{{dt.STAFF_NAME}}</h6>
                                                            <span class=" mb-0 text-muted font-italic  " style="font-size: 0.60rem;">{{dt.STAFF_DESC}}</span>
                                                            <span data-ng-if="(emp_id == dt.OWNERID || emp_approver == true || emp_teamheader == true ||  emp_admin == true) && (dt.PLANS_COMPLETE==null?0:dt.PLANS_COMPLETE >0)" class="success font-small-2 mt-0">See detail&#32;<i class="fa fa-long-arrow-right" aria-hidden="true"></i></span>

                                                        </div>
                                                        <div class="col-6">
                                                            <div class="row justify-content-lg-end">

                                                                <div class="flex-grow-0 d-flex flex-column justify-content-center mr-1">
                                                                    <span class=" text-black text-center font-medium-1 font-weight-bold d-flex justify-content-center">{{((dt.VALUES_COMPLETE == null) ? 0 :dt.VALUES_COMPLETE /dt.PLANS_COMPLETE)*100 | number:0}}%</span>
                                                                    <span class="  text-black text-center font-weight-normal success  d-flex justify-content-center pl-0 font-small-1">{{(dt.VALUES_COMPLETE == null) ? 0 :dt.VALUES_COMPLETE}} / {{dt.PLANS_COMPLETE}}</span>
                                                                    <span class="  text-black text-center font-weight-normal d-flex justify-content-center pl-0 font-small-1">Completed/Total</span>
                                                                </div>

                                                            </div>

                                                        </div>


                                                    </div>
                                                </div>
                                            </div>

                                        </a>
                                    </div>

                                </div>

                            </div>
                            <div class="col-12" data-html2canvas-ignore="false">
                                <small class="cursor-pointer font-small-1 mt-1 danger float-right" data-ng-if="show_moredetail !='show'" data-ng-click="on_click_moredetail('show')"><i class="fa fa-eye" aria-hidden="true"></i>&#32;Show table detail</small>
                            </div>
                        </div>
                         

                    </div>

                </div>
            </div>
            <div class="row pt-1" data-ng-if="show_moredetail =='show'">
                <div class="col-xl-12">
                    <div class="card box-shadow-1 ">
                        <div class="card-header pb-0">
                            <label class="text-uppercase font-weight-bold">{{text_type}}</label>
                            <small class="w-auto cursor-pointer font-small-1 danger float-right ml-1" data-ng-click="on_click_moredetail('hide')"><i class="fa fa-eye-slash" aria-hidden="true"></i>&#32;Hidden table detail</small>
                            <a data-html2canvas-ignore="false" data-ng-click="exportToExcel('#tableToExport')" class=" float-right btn btn-social  btn-xs btn-outline-success  bg-success  white "><span class="fa fa-file-excel-o" aria-hidden="true"></span>generate Excel</a>
                        </div>
                        <div class="card-body">

                            <div class="col-6 pr-0 ml-auto">
                                <div class="col-12">
                                    <div class="row">
                                        <div class="col-3">
                                            <div class="card  m-0">
                                                <div class="card-header p-0 m-0">
                                                    <h4 class="font-size-xsmall">Plant Date</h4>
                                                </div>

                                                <div class="card-content">
                                                    <select class="select_filler form-control form-control-sm" id="param_month_select" data-ng-model="table_filter.MONTH_NAME" data-ng-change="searchfilter(table_filter.MONTH_NAME,'MONTH_NAME')">
                                                        <option value="">All</option>
                                                        <option value="{{dt.NAME}}" data-ng-repeat="dt in dtplan_select | orderBy:'CODE'">{{dt.NAME}}</option>
                                                    </select>
                                                </div>



                                            </div>
                                        </div>

                                        <div class="col-3">
                                            <div class="card  m-0">
                                                <div class="card-header p-0 m-0">
                                                    <h4 class="font-size-xsmall">Course Name</h4>
                                                </div>
                                                <div class="card-content">
                                                    <select class="select_filler form-control form-control-sm" id="param_course_select" data-ng-change="searchfilter(table_filter.COURSE_NAME,'COURSE_NAME')"
                                                        data-ng-model="table_filter.COURSE_NAME">
                                                        <option value="">All</option>
                                                        <option value="{{dt}}" data-ng-repeat="dt in dtcours_name">{{dt}}</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-3">
                                            <div class="card  m-0">
                                                <div class="card-header p-0 m-0">
                                                    <h4 class="font-size-xsmall">Course Type</h4>
                                                </div>
                                                <div class="card-content">

                                                    <select class="select_filler form-control form-control-sm" id="param_method_select" data-ng-model="table_filter.COURSE_TYPE" data-ng-change="searchfilter(table_filter.COURSE_TYPE,'COURSE_TYPE')">

                                                        <option value="">All</option>
                                                        <option value="{{dt}}" data-ng-repeat="dt in dtcours_type">{{dt}}</option>
                                                    </select>
                                                </div>

                                            </div>
                                        </div>

                                        <div class="col-3 p-0">
                                            <div class="card m-0">
                                                <div class="card-header p-0 m-0">
                                                    <h4 class="font-size-xsmall">Status</h4>
                                                </div>
                                                <div class="card-content">
                                                    <div class="card-body text-center p-0 table-responsive  position-relative  ps-container ps-theme-default ps-active-y pr-1">

                                                        <select class="select2 select_filler form-control form-control-sm" data-ng-model="table_filter.STATUS" data-ng-change="searchfilter(table_filter.STATUS,'STATUS')">
                                                            <option value="">All</option>
                                                            <option value="Completed">Completed</option>
                                                            <option value="Not started">Not started</option>
                                                        </select>
                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="card-body py-0 pb-1 px-1">

                            <div class="col-12 px-0 pb-1">

                                <div class="table-responsive  height-250    font-size-small">
                                    <style>
                                        .tableFixHead thead tr th {
                                            position: sticky;
                                            top: -2px;
                                            background: #ECEFF1 !important
                                        }

                                        .table thead tr th {
                                            text-align: center;
                                            vertical-align: middle;
                                            padding: 8px 8px;
                                            font-size: 0.8em;
                                        }

                                        .table tbody tr td {
                                            text-align: center;
                                            vertical-align: middle;
                                            font-size: 0.7em;
                                            padding: 8px 5px
                                        }
                                    </style>

                                    <table class="table table-bordered tableFixHead">
                                        <thead>
                                            <tr class="bg-blue-grey bg-lighten-5">
                                                <%-- <th style="vertical-align: middle">Year</th>--%>
                                                <th style="vertical-align: middle">Plan Date</th>
                                                <th style="vertical-align: middle">Date From</th>
                                                <th style="vertical-align: middle">Date To</th>
                                                <th class=" width-150" style="vertical-align: middle">Name</th>
                                                <th style="vertical-align: middle">Employee No</th>
                                                <th style="vertical-align: middle" class="d-none">Job Group</th>
                                                <th style="vertical-align: middle">Employee catagories</th>
                                                <th style="vertical-align: middle">Unit</th>
                                                <th style="vertical-align: middle">Team</th>
                                                <th style="vertical-align: middle">Course Name</th>
                                                <th style="vertical-align: middle">Course Type</th>
                                                <th style="vertical-align: middle">Institute/Instructor</th>
                                                <th style="vertical-align: middle">Status</th>
                                                <th style="vertical-align: middle">Source</th>
                                                <%--         <th style="vertical-align: middle">Exam Result</th>--%>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr data-ng-repeat="dsemp in idp_details | filter:table_filter" data-ng-if="emp_id == dsemp.EMPLOYEE_ID || emp_admin == true">

                                                <%--<td>{{dsemp.YEAR}}</td>--%>
                                                <td>{{dsemp.MONTH_NAME}}</td>
                                                <td class="text-nowrap">{{dsemp.CONDUCTED_DATE_FROM | date:'dd-MMM-yyyy'}}</td>
                                                <td class="text-nowrap">{{dsemp.CONDUCTED_DATE_TO | date:'dd-MMM-yyyy'}}</td>
                                                <td class="text-nowrap">{{dsemp.EMPLOYEE_NAME}}</td>
                                                <td>{{dsemp.EMPLOYEE_ID}}</td>
                                                <td class="d-none">{{dsemp.JOB_GROUP}}</td>
                                                <td>{{dsemp.CATEGORY}}</td>
                                                <td class="text-nowrap">{{dsemp.UNIT}}</td>
                                                <td class="text-nowrap">{{dsemp.TEAM}}</td>
                                                <td class="text-left">{{dsemp.COURSE_NAME}}</td>
                                                <td class="text-nowrap">{{dsemp.COURSE_TYPE}}</td>
                                                <td>{{dsemp.INSTITUTE_INSTRUCTOR}}</td>
                                                <td>{{dsemp.STATUS}}</td>
                                                <td class="text-nowrap">{{dsemp.SOURCE}}</td>
                                                <%--     <td>{{dsemp.EXAM_RESULT}}</td>--%>
                                            </tr>

                                            <!-- end ngIf: dsemp.YEAR == year_select -->
                                            <!-- end ngRepeat: dsemp in ds_by_emp -->
                                        </tbody>
                                    </table>
                                    <div class="ps-scrollbar-x-rail" style="width: 100%; left: 0px; bottom: 3px;">
                                        <div class="ps-scrollbar-x" tabindex="0" style="left: 0px; width: 1716px;"></div>
                                    </div>
                                    <div class="ps-scrollbar-y-rail" style="top: 0px; right: 3px;">
                                        <div class="ps-scrollbar-y" tabindex="0" style="top: 0px; height: 0px;"></div>
                                    </div>
                                </div>


                            </div>
                            <div id="tableToExport">
                                <table class="table" border="1" style="display: none">
                                    <thead>
                                        <tr>
                                            <%--<th style="vertical-align: middle; background-color: #588da8;">Year</th>--%>
                                            <th style="vertical-align: middle; background-color: #588da8">Plan Date</th>
                                            <th style="vertical-align: middle; background-color: #588da8">Conducted Date From</th>

                                            <th style="vertical-align: middle; background-color: #588da8">Conducted Date To</th>

                                            <th class=" width-150" style="vertical-align: middle; background-color: #588da8">Name</th>
                                            <th style="vertical-align: middle; background-color: #588da8">Employee No</th>
                                            <th style="vertical-align: middle; background-color: #588da8" class="d-none">Job Group</th>
                                            <th style="vertical-align: middle; background-color: #588da8">Employee catagories</th>
                                            <th style="vertical-align: middle; background-color: #588da8">Unit</th>
                                            <th style="vertical-align: middle; background-color: #588da8">Team</th>
                                            <th style="vertical-align: middle; background-color: #588da8">Course Name</th>
                                            <th style="vertical-align: middle; background-color: #588da8">Course Type</th>
                                            <th style="vertical-align: middle; background-color: #588da8">Institute/Instructor</th>
                                            <th style="vertical-align: middle; background-color: #588da8">Status</th>
                                            <th style="vertical-align: middle; background-color: #588da8">Source</th>
                                            <%--<th style="vertical-align: middle; background-color: #588da8">Exam Result</th>--%>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr data-ng-repeat="dsemp in idp_details | filter:table_filter">

                                            <%--<td>{{dsemp.YEAR}}</td>--%>
                                            <td>{{dsemp.MONTH_NAME}}</td>
                                            <td class="text-nowrap">{{dsemp.CONDUCTED_DATE_FROM | date:'dd-MMM-yyyy'}}</td>
                                            <td class="text-nowrap">{{dsemp.CONDUCTED_DATE_TO | date:'dd-MMM-yyyy'}}</td>
                                            <td class="text-nowrap">{{dsemp.EMPLOYEE_NAME}}</td>
                                            <td>{{dsemp.EMPLOYEE_ID}}</td>
                                            <td>{{dsemp.JOB_GROUP}}</td>
                                            <td>{{dsemp.CATEGORY}}</td>
                                            <td class="text-nowrap">{{dsemp.UNIT}}</td>
                                            <td class="text-nowrap">{{dsemp.TEAM}}</td>
                                            <td>{{dsemp.COURSE_NAME}}</td>
                                            <td class="text-nowrap">{{dsemp.COURSE_TYPE}}</td>
                                            <td>{{dsemp.INSTITUTE_INSTRUCTOR}}</td>
                                            <td>{{dsemp.STATUS}}</td>
                                            <td class="text-nowrap">{{dsemp.SOURCE}}</td>
                                            <%--<td>{{dsemp.EXAM_RESULT}}</td>--%>
                                        </tr>

                                        <!-- end ngIf: dsemp.YEAR == year_select -->
                                        <!-- end ngRepeat: dsemp in ds_by_emp -->
                                    </tbody>
                                </table>
                            </div>
                        </div>


                    </div>

                </div>
            </div>

            <div class="text-center mt-0 mb-0">
                <p class="font-size-xsmall blue-grey">Strictly Confidential (for internal use only)</p>
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
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="JS/PerfectScrollBar.js"></script>

    <script>

        var app = angular.module('app', [])
        var url_ws_other = "http://tsr-qdms-les.thaioil.localnet/eosl/webservice/wsform_admin_other.asmx";

        var dateNow = new Date(), m = dateNow.getMonth(), y = dateNow.getFullYear();
        var lab = 'EOSL';
        var month_def = moment().format('MMM');
        var year_def = moment().format('YYYY');
        var momentNow = moment();

        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        })
        app.factory('Excel', function ($window) {
            var uri = 'data:application/vnd.ms-excel;base64,',
                template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>',
                base64 = function (s) { return $window.btoa(unescape(encodeURIComponent(s))); },
                format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) };
            return {
                tableToExcel: function (tableId, worksheetName) {
                    var table = $(tableId),
                        ctx = { worksheet: worksheetName, table: table.html() },
                        href = uri + base64(format(template, ctx));
                    return href;
                }
            };
        });
        app.controller('ctrlApp', function (Excel, $timeout, $scope, $http) {

            $scope.exportToExcel = function (tableId) { // ex: '#my-table'
                if ($scope.type_excel == "monthly") { tableId = tableToExport }
                else { tableId = tableToExport }
                var exportHref = Excel.tableToExcel(tableId, 'WireWorkbenchDataExport');
                $timeout(function () { location.href = exportHref; }, 100); // trigger download
            }

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
                while (itm = pattern.exec(qs)) {
                    if (key !== false && decodeURIComponent(itm[1]) === key)
                        return decodeURIComponent(itm[2]);
                    else if (key === false)
                        res[decodeURIComponent(itm[1])] = decodeURIComponent(itm[2]);
                }

                return key === false ? res : null;
            }

            var session_user_login = '<%= Session["user_name"]%>';
             //var session_user_login = 'SUTTHIWAT';//eosl
            //var session_user_login = 'PREECHANAN'; //manager
            //var session_user_login = 'SANGCHAI'; //manager - A
            //var session_user_login = 'SOONTHORNA';//employee-->senior
            //var session_user_login = 'JADET'; //employee-->senior
            //var session_user_login = 'BENSIYA'; //employee-->TEAM ANALYST - C
            //var session_user_login = 'SUTEP'; //manager - A
            var session_unit_diff = 'EOSL';
            //alert(session_user_login);
            //ดึงข้อมูลมาตั้งต้น
            page_load();
            function get_data_in_username(unit_name, team_name, unit_def, team_def, empid_def, action_diff, action_diff_approver) {
                var user_name = session_user_login;
                var user_id = "";
                var year = $scope.year_select;
                var unit_name = "";//$scope.unit_code_select;
                var team_name = "";


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
                $scope.emp_teamheader = false;

                if (session_user_login.toUpperCase() == "ADMIN") {
                    $scope.emp_admin = true; $scope.emp_approver = true; if (unit_def != "") { user_name = ""; user_id = empid_def; unit_name = unit_def; team_name = team_def; }
                }
                if (action_diff_approver ==true) {
                    $scope.emp_admin = true; $scope.emp_approver = true; if (unit_def != "") { user_name = ""; user_id = empid_def; unit_name = unit_def; team_name = team_def; }
                    user_name = "";
                }
                 
                $.ajax({
                    type: "POST",
                    url: url_ws_other + "/get_emp_data_idp",
                    data: '{"year":"' + year + '","user_name":"' + user_name + '","user_id":"' + user_id + '","unit":"' + unit_name + '","team":"' + team_name + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        try {
                            var arr = JSON.parse(data.d);
                        } catch{
                            alert(data.d);
                            return;
                        }
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

                            if ($scope.job_role.toLowerCase() == "manager" && $scope.unit_code == session_unit_diff) { $scope.emp_approver = true; }
                            else if ($scope.job_role.toLowerCase() == "manager" && $scope.unit_code == $scope.unit_code_select) { $scope.emp_approver = true; }
                            else if ($scope.job_role.toLowerCase() == "manager" && $scope.team_code == $scope.session_team_diff) { $scope.emp_approver = true; }

                            if (session_user_login.toUpperCase() == "ADMIN") { $scope.emp_admin = true; $scope.emp_approver = true; }

                            var MAIN_POS_INIDICATOR = arr.emp_details[0].MAIN_POS_INIDICATOR.replace(" ", "");
                            if (MAIN_POS_INIDICATOR.indexOf("ASSISTANTLAB.MANAGER") > -1) {
                                $scope.emp_teamheader = true;
                            } 

                            $scope.$apply();
 
                            if ($scope.unit_code.toString() != "" && action_diff == true) {

                                window.location.assign("idp_by_employees_detail.aspx?unit_name=" + $scope.unit_code + "&team_name=" + $scope.team_code +
                                    "&employees_name=" + $scope.emp_userdisplay + "&employees_id=" + $scope.emp_id + "&year=" + $scope.year_select +
                                    "&pass_page=employee"); 
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
            $scope.on_click_next = function (team_name, employee_name, employee_id) {

                if ($scope.emp_admin == true) {  
                    //get user in diff
                    get_data_in_username("", "", $scope.unit_code_select, team_name, employee_id, true,false); 
                    return;
                }
                if ($scope.emp_approver == true) {  
                    //get user in diff
                    get_data_in_username("", "", $scope.unit_code_select, team_name, employee_id, true,true); 
                    return;
                }


                //จะมีแต่ user ที่มีสิทธิ์เข้าดูข้อมูล IDP ถึงจะมาถึง step นี้
                if ($scope.emp_id == employee_id) {
                    //ไปหน้า detail 
                    $scope.emp_status = true;
                    $scope.emp_dif = true;
                } else {
                    //ไม่มีสิทธิ์เข้าดู unit 
                    $scope.emp_status = false;
                }

                if ($scope.emp_status == true) {
                    if ($scope.emp_dif == true) {
                        //ดูได้เฉพาะเจ้าตัว
                        window.location.assign("idp_by_employees_detail.aspx?unit_name=" + $scope.unit_code + "&team_name=" + $scope.team_code +
                            "&employees_name=" + $scope.emp_userdisplay + "&employees_id=" + $scope.emp_id + "&year=" + $scope.year_select);
                    } else {
                        //อาจจะต้องทำแจ้งเตือนว่าไม่มีสิทธิ์
                    }
                } else {
                    //อาจจะต้องทำแจ้งเตือนว่าไม่มีสิทธิ์

                    if ($scope.emp_teamheader == true) {
                        //Team Header
                        get_data_in_username("", "", $scope.unit_code_select, team_name, employee_id, true, true); 
                        //window.location.assign("idp_by_employees_detail.aspx?unit_name=" + $scope.unit_code + "&team_name=" + $scope.team_code +
                        //    "&employees_name=" + $scope.emp_userdisplay + "&employees_id=" + $scope.emp_id + "&year=" + $scope.year_select);
                    }

                }
                //window.open("IDP_by_employees_detail.aspx?unit_name=" + unit + "&team_name=" + team_name + "&employees_name=" + name_emp + "&employees_id=" + $.trim(emp_id), "_top");
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

                if (year_select == "") {
                    $scope.YEAR_SIMPLE = "IDP By " + team_name + "  (JAN - " + month_def + " " + year_def + ")";
                } else {
                    if (+year_select < +year_def && year_select != "") {
                        $scope.YEAR_SIMPLE = "IDP By " + team_name + "  (JAN - DEC " + year_select + ")";
                    } else {
                        $scope.YEAR_SIMPLE = "IDP By " + team_name + "  (JAN - " + month_def + " " + year_select + ")";
                    }
                }
                //ตรวรจสอบสิทธิ์ใหม่ตามปี
                get_data_in_username();
                getdata_idp(true);

            }
            $scope.on_click_moredetail = function (val_type) {
                $scope.show_moredetail = val_type;
            }
            $scope.cls_sort_jobroles = function (ilength) {
                if (ilength == 4) { return "col-3"; } else { return "col-4"; }
            }
            $scope.searchfilter = function (val, fill) {
                var data = val == null ? "" : val;
                $scope.table_filter[fill] = data;
                apply();
            }
            $scope.pfd_print = function screenshot() {

                var chb = CheckBrowser();
                if (chb == 'isEdge') {
                    $('#chartOvertime').hide();
                    $('#demoimg').fadeIn();
                }


                document.getElementById("card_cut1").className = " border_print";
                document.getElementById("card_cut2").className = " border_print";
                document.getElementById("card_1").className = " border_print";
                document.getElementById("card_2").className = " border_print";
                document.getElementById("card_3").className = " border_print";

                var HTML_Width = $(".canvas_div_pdf").width();
                var HTML_Height = $(".canvas_div_pdf").height();
                var top_left_margin = 1;
                var PDF_Width = HTML_Width + (top_left_margin * 2);
                var PDF_Height = (PDF_Width * 1.5) + (top_left_margin * 2);
                var canvas_image_width = HTML_Width;
                var canvas_image_height = HTML_Height;

                //HTML_Width = HTML_Width * 20;
                //HTML_Height = HTML_Height * 20;
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

                canvas_image_width = HTML_Width - 10;
                canvas_image_height = HTML_Height;

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
                    canvas_image_width = (HTML_Width_Def * (icount_def - 0));
                    canvas_image_height = (HTML_Height_Def * (icount_def));
                    HTML_Width_Header = canvas_image_width;
                }
                if (checkw_window == 1730) {

                    var HTML_Width_Def = $(".canvas_div_pdf").width();
                    var HTML_Height_Def = $(".canvas_div_pdf").height();
                    canvas_image_width = (HTML_Width_Def * (icount_def - 0));
                    canvas_image_height = (HTML_Height_Def * (icount_def));
                    HTML_Width_Header = canvas_image_width;
                }
                if (checkw_window > 1900) {

                    var HTML_Width_Def = $(".canvas_div_pdf").width();
                    var HTML_Height_Def = $(".canvas_div_pdf").height();
                    canvas_image_width = (HTML_Width_Def * (icount_def - 0));
                    canvas_image_height = (HTML_Height_Def * (icount_def + 0.5));
                    HTML_Width_Header = canvas_image_width;
                }

                var totalPDFPages = Math.ceil(HTML_Height / PDF_Height) - 1;

                html2canvas(document.querySelector("#divPage")).then(canvas = function (canvas) {

                    canvas.getContext('2d');
                    canvas.font = 'bold 48px Times New Roman 12pt';
                    var imgData = canvas.toDataURL("image/jpeg", 1.0);
                    $scope.ImgDataS = imgData;


                    var pdf = new jsPDF('l', 'pt', [PDF_Width + 100, PDF_Height + 250]);
                    pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin - 0, canvas_image_width, canvas_image_height);

                    if (totalPDFPages <= 1) {

                        var today = moment().format('LLLL');//new Date();
                        var newdat = "Date Printed : " + today;
                        var newdat2 = "Print From EOSL Dashboard System";
                        pdf.setFont("courier");
                        pdf.setFontSize(50);
                        //pdf.text(HTML_Width * 0.8, PDF_Height - 50, newdat);




                        if (checkw_window == 1980) {
                            pdf.text(newdat, HTML_Width_Header * 0.7, 80);

                            //pdf.text(HTML_Width * 0.8, PDF_Height - 30, newdat2);
                            pdf.text(newdat2, HTML_Width_Header * 0.70, 40);
                        }
                        else if (checkw_window == 1730) {
                            pdf.text(newdat, HTML_Width_Header * 0.7, 80);

                            //pdf.text(HTML_Width * 0.8, PDF_Height - 30, newdat2);
                            pdf.text(newdat2, HTML_Width_Header * 0.70, 40);

                        }
                        else {

                            pdf.text(newdat, HTML_Width_Header * 0.74, 80);

                            //pdf.text(HTML_Width * 0.8, PDF_Height - 30, newdat2);
                            pdf.text(newdat2, HTML_Width_Header * 0.72, 40);


                        }
                    }
                    for (var i = 1; i <= totalPDFPages; i++) {
                        pdf.addPage(PDF_Width, PDF_Height);
                        pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height * i) + (top_left_margin * 4), canvas_image_width, canvas_image_height);

                    }
                    //var dateNow = new Date(), m = dateNow.getMonth(), y = dateNow.getFullYear();getDate() 
                    //pdf.save("HTML-Document.pdf");
                    pdf.save("EOSL_DASHBOARD_" + momentNow.format('YYYYMMDDHHMMSS') + ".pdf");
                    //pdf.save("HTML-Document.pdf");

                    document.getElementById("card_cut1").className = "card box-shadow-1 pb-0 mb-0";
                    document.getElementById("card_cut2").className = "card box-shadow-1 pb-0 mb-0";
                    document.getElementById("card_1").className = "card box-shadow-1";
                    document.getElementById("card_2").className = "card box-shadow-1";
                    document.getElementById("card_3").className = "card box-shadow-1";

                    $("#divLoading").hide();



                    if (chb == 'isEdge') {
                        $('#chartOvertime').show();
                        $('#demoimg').hide();
                    }

                });


            }
            $scope.range = function (min, max, step) {
                step = step || 1;
                var input = [];
                for (var i = min; i <= max; i += step) input.push(i);
                return input;
            };
            $scope.on_change_idp_type = function () {

                data_to_chart_gap_again(true);
            }
            function getdata_idp() {
                var year = $scope.year_select;
                var unit = $scope.unit_code_select;
                var team = $scope.team_code_select;
                var user_name = "";
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
                        if (year == "") {
                            $scope.YEAR_SIMPLE = "IDP By " + team + "  (JAN - " + month_def + " " + year_def + ")";
                        }

                        var arr = JSON.parse(data.d);
                        $scope.dtidp_totals = arr.idp_total;
                        $scope.arr_div_box_css = ['pl-1', 'pl-0', 'pl-0', 'pl-0', 'pl-1', ' pl-0', ' pl-0', ' pl-0'];
                        //$scope.arr_css = ['bg-info', 'bg-yellow bg-darken-1', ' bg-info bg-lighten-2', 'bg-pink bg-lighten-2', 'bg-blue darken-4', 'bg-success bg-lighten-2'];
                        $scope.arr_css = ['#00A5E3', '#8DD7BF', '#FF69C5', '#FF5768', '#FFBF65', '#50B4D8', '#96B3C2', '#ea9085'];
                        $scope.completion_agian_plan = arr.idp_completion_month;
                        $scope.completion_gap_closing = arr.idp_gap_closing_month;
                        $scope.idp_overalls = arr.idp_overalls;
                        $scope.idp_by_jobroles = arr.idp_completion_jobrole;
                        $scope.idp_overall_teams = arr.idp_overall_team;
                        $scope.idp_overall_staffs = arr.idp_overall_staff;
                        $scope.dtidp_overall_staff_sort_jobroles = arr.idp_overall_staff_sort_jobrole;
                        $scope.idp_details = arr.idp_details;

                        //staff color by emp
                        var shade_byemp = [
                            '#ff1a1a', '#ffff00', '#ff8000', '#ffbf00',
                            '#00bfff', '#bfff00', '#80ff00', '#40ff00',
                            '#00ff40', '#ff4000', '#00ff80', '#00ff00',
                            '#00ffbf', '#00ffff', '#0080ff', '#0040ff'];
                        var irow = 0;
                        $scope.color_type_emp = $scope.idp_details.map(function (d) { return d.EMPLOYEE_NAME }).filter(function (v, i, data) { return i == data.indexOf(v) })
                            .map(function (da) {
                                if (irow == 16) {
                                    irow = 0;
                                }
                                var obj = { NAME: da, COLOR: shade_byemp[irow] }
                                irow++
                                return obj
                            });
                        $scope.icol_sort = 0;
                        var irow = 1; var icol = 0;
                        var arr_copy = arr.idp_overall_staff;
                        //arr_copy.sort(function (a, b) { return a.EMP_SORT - b.EMP_SORT });
                        debugger;
                        for (var il = 0; il < arr.idp_overall_staff_sort_jobrole.length; il++) {

                            for (var j = 0; j < arr.idp_overall_staff.length; j++) {
                                if (arr.idp_overall_staff[j].EMP_GROUP_SORT == arr.idp_overall_staff_sort_jobrole[il].EMP_GROUP_SORT) {

                                    arr_copy[j].ICOL = icol;
                                    arr_copy[j].IROW = irow;

                                    icol++;
                                    irow++;
                                    if (irow == 4) { irow = 1; $scope.icol_sort++; }
                                }
                            }
                        }

                        $scope.idp_overall_staffs_new = arr.idp_overall_staff;

                        //cplorbytype 
                        $scope.arr_type_color = $scope.dtidp_totals.map(function (d, i) {
                            var color_select = $scope.arr_css[i];
                            return { TYPE: d.TYPE_NAME, COLOR: color_select }
                        });

                        //cousetype
                        $scope.dtcours_type = $scope.idp_details.map(function (d) { return d.COURSE_TYPE }).filter(function (v, i, data) { return i == data.indexOf(v) });
                        //cousename
                        $scope.dtcours_name = $scope.idp_details.map(function (d) { return d.COURSE_NAME }).filter(function (v, i, data) { return i == data.indexOf(v) });
                        //plan
                        $scope.dtplan_select = $scope.idp_details.map(function (d) {

                            var imonth = +moment(d.MONTH_NAME, 'MMM').format('M');
                            var obj = { CODE: imonth, NAME: d.MONTH_NAME };

                            return obj
                        }).filter(function (v, i, data) { return i == data.findIndex(function (iw) { return iw.NAME == v.NAME }) });

                        //setjob tolower
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
                            } else {
                                $scope.idp_by_jobroles.push({
                                    "BY_TYPE_NAME": "Junior"
                                    , "MONTH": 1, "MONTH_SHORT": "Jan"
                                    , "PLANS_COMPLETE": 0
                                    , "VALUES_COMPLETE": 0
                                });
                            }
                            if (d.BY_TYPE_NAME == "supervisor") {
                                d.BY_TYPE_NAME = 'Supervisor';
                            } else {
                                $scope.idp_by_jobroles.push({
                                    "BY_TYPE_NAME": "Supervisor"
                                    , "MONTH": 1, "MONTH_SHORT": "Jan"
                                    , "PLANS_COMPLETE": 0
                                    , "VALUES_COMPLETE": 0
                                });
                            }
                            if (d.BY_TYPE_NAME == "senior") {
                                d.BY_TYPE_NAME = 'Senior';
                            } else {
                                $scope.idp_by_jobroles.push({
                                    "BY_TYPE_NAME": "Senior"
                                    , "MONTH": 1, "MONTH_SHORT": "Jan"
                                    , "PLANS_COMPLETE": 0
                                    , "VALUES_COMPLETE": 0
                                });
                            }

                        });

                        $scope.complete_idp = arr.idp_overall_team[0].VALUES_COMPLETE == null ? 0 : arr.idp_overall_team[0].VALUES_COMPLETE;
                        $scope.plan_idp = arr.idp_overall_team[0].PLANS_COMPLETE == null ? 0 : arr.idp_overall_team[0].PLANS_COMPLETE;

                        //Auwat Start 
                        $scope.arr_css_style2 = ['#00A5E3', '#8DD7BF', '#FF69C5', '#FF5768', '#FFBF65', '#50B4D8', '#96B3C2'];
                        $scope.arr_css_style2 = ['#00A5E3', '#8DD7BF', '#FF69C5', '#FF5768', '#FFBF65', '#50B4D8', '#96B3C2', '#ea9085'];
                        $scope.fillter_type_chart_idp = "";//'#2494CC', '#00E396', '#FEB019', '#FF4560', '#FFFFFF'
                        $scope.fillter_type_chart_gap = "";//'#2494CC', '#00E396', '#FEB019', '#FF4560', '#FFFFFF' 
                        $scope.listjobroles_idp = [{ "COLOR": "#00E396", "NAME": "Senior", "STATUS": true }];
                        $scope.listjobroles_idp.push({ "COLOR": "#FEB019", "NAME": "Supervisor", "STATUS": true });
                        $scope.listjobroles_idp.push({ "COLOR": "#FF4560", "NAME": "Junior", "STATUS": true });
                        $scope.listjobroles_gap = angular.copy($scope.listjobroles_idp);
                        //Auwat End


                        $scope.$apply();


                        set_chart_pie_main($scope.complete_idp, $scope.plan_idp);

                        $('#chart_idp').html('');
                        $('#chart_idp_plan').html('');
                        $('#chart_gap_plan').html('');

                        get_apex_bar_chart_switch("chart_idp_plan", 1, 'againt_plan');
                        get_apex_bar_chart_switch("chart_gap_plan", 1, 'gap_closing');
                        get_apex_bar_chart("chart_idp", 4, 'jobrole');


                        $(window).on("resize", function () {

                        }).resize();
                        $("#divLoading").hide();
                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert("error:" + errorMessage);
                        $("#divLoading").hide();
                    }
                });
            }
            function page_load() {

                var unit_name = getQueryString('unit_name')
                var team_name = getQueryString('team_name')
                var year = getQueryString('year')

                $scope.session_team_diff = team_name;// กรณีที่เป็นหัวหน้าข้อมูล unit & team จะเป็นชื่อเดียวกันอยู๋แล้ว
                $scope.unit_code_select = unit_name;
                $scope.team_code_select = team_name;
                $scope.year_select = year;
                $scope.idp_chart_type = "jobrole";

                get_data_in_username("", "", "", "", "",false,false);


                $("#chart_idp_plan").html("");
                $("#chart_gap_plan").html("");


                $scope.text_type = "%IDP Completion  By STAFF";
                $scope.text_COMPETENCY = "Staff Development  By " + team_name;
                $scope.text_IDP = "IDP Completion againt plan " + team_name;
                $scope.text_IDP_BY_JONROLE = "IDP Completion BY Employee catagories " + team_name;
                $scope.text_GAP = "Gap Closing completion againt plan " + team_name;

                if (+year < +year_def && year != "") {
                    $scope.YEAR_SIMPLE = "IDP By " + team_name + "  (JAN - DEC " + year + ")";
                } else {
                    $scope.YEAR_SIMPLE = "IDP By " + team_name + "  (JAN - " + month_def + " " + year + ")";
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

                        $scope.$apply();

                        getdata_idp(team_name);
                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert("error:" + errorMessage);
                        $("#divLoading").hide();
                    }
                });

            }
            function set_chart_pie_main(complete, plan) {

                var dom = document.getElementById("chart_pie_staff_deverlopment");
                var myChart = echarts.init(dom);

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
            function get_data_binde_chart_bk(data, xtype) {

                if (xtype == 'jobrole') {
                    $scope.data_tooltip_jobrole = data;
                    var job_role = ['Manager', 'Senior', 'Supervisor', 'Junior'];
                    var job_role = ['Senior', 'Supervisor', 'Junior'];
                    var arrdupicate = [];
                    var objs = [];
                    var obj = [];
                    //created obj by role
                    job_role.forEach(function (d) {
                        var find_index = arrdupicate.findIndex(function (x) { return x == d });


                        var filter_d = 12;
                        if (find_index == -1) {
                            var obj_x = { name: d, data: Array(4).fill(0), value: 0, xtotal: 0 };
                            objs.push(obj_x);
                        }
                        arrdupicate.push(d);
                    });

                    for (var i in objs) {

                        for (var x in data) {
                            objs[i].xtotal += data[x].PLANS_COMPLETE;


                        }
                    }

                    for (var i in objs) {

                        for (var x in data) {

                            if (objs[i].name == data[x].BY_TYPE_NAME) {
                                //objs[i].value += ((data[x].VALUES_COMPLETE / objs[0].xtotal) * 100).toFixed(0);
                                objs[i].value += data[x].VALUES_COMPLETE;

                            }

                        }
                    } 

                    job_role.forEach(function (v, i) {

                        objs.forEach(function (d) {
                            if (d.name == v) {
                                obj[i] = d.value;
                            }

                        });

                    });



                }
                else {
                    var type_name = $scope.idp_chart_type;

                    var data = data.filter(function (x) { return x.BY_TYPE_NAME == type_name });
                    if (xtype == 'gap_closing') {
                        $scope.data_tooltip_gap = data;
                    }
                    else { $scope.data_tooltip_again = data; }

                     
                    if (type_name == "jobrole") {
                        var d_type = ['Manager', 'Senior', 'Supervisor', 'Junior'];
                        var d_type = ['Senior', 'Supervisor', 'Junior'];
                    }
                    else {
                        var d_type = data;

                    }
                    //กรณที่เปลียน type
                    var arrdupicate = [];

                    var objf = [];
                    var objs = [];
                    d_type.forEach(function (d) {
                        if (type_name == 'jobrole') { var find_index = arrdupicate.findIndex(function (x) { return x == d }); }
                        else {
                            var find_index = arrdupicate.findIndex(function (x) { return x == d.TYPE_CODE });
                        }
                        var filter_d = 12;
                        if (find_index == -1) {
                            if (type_name == 'staff') {
                                var obj_x = { name: d.TYPE_NAME, data: Array(filter_d).fill(0), stype: xtype, xtotal: 0 };
                            }
                            else if (type_name == 'jobrole') { var obj_x = { name: d, data: Array(filter_d).fill(0), stype: xtype, xtotal: 0 }; }
                            else {
                                var obj_x = { name: d.TYPE_CODE, data: Array(filter_d).fill(0), stype: xtype, xtotal: 0 };
                            }
                            objf.push(obj_x);
                        }

                        arrdupicate.push(d.TYPE_CODE);

                    });

                    //sort Manager,Senior,Supervisor,Junior
                    if (type_name == "jobrole") {
                        var d_type = ['Manager', 'Senior', 'Supervisor', 'Junior'];
                        var d_type = ['Senior', 'Supervisor', 'Junior'];
                    }
                    else {

                        var d_type = objf.map(function (d) { return d.name });

                    }

                    for (var i in d_type) {
                        for (var x in objf) {

                            if (d_type[i] == objf[x].name) {
                                objs.push(objf[x]);
                                break;

                            }
                        }

                    }


                    $scope.data_xaxis = objs.map(function (d) { return d.name });
                    //push ค่า ใส่ obj
                    obj = objs;
                    var arr_total_month = Array(12).fill(0);
                    //หา total
                    for (var i in obj) {
                        for (var x in data) {
                            obj[i].xtotal += (data[x].PLANS_COMPLETE == null) ? 0 : data[x].PLANS_COMPLETE;

                            if (type_name == 'staff') {
                                if (obj[i].name == data[x].TYPE_NAME) {
                                    var month_index = (data[x].MONTH - 1);
                                    //alert(month_index);
                                    arr_total_month[month_index] += (data[x].PLANS_COMPLETE == null) ? 0 : data[x].PLANS_COMPLETE;
                                    obj[i].data[month_index] += (data[x].VALUES_COMPLETE == null) ? 0 : data[x].VALUES_COMPLETE;

                                }
                            }
                            else {
                                if (obj[i].name == data[x].TYPE_CODE) {
                                    var month_index = (data[x].MONTH - 1);
                                    //alert(month_index);
                                    arr_total_month[month_index] += (data[x].PLANS_COMPLETE == null) ? 0 : data[x].PLANS_COMPLETE;
                                    obj[i].data[month_index] += (data[x].VALUES_COMPLETE == null) ? 0 : data[x].VALUES_COMPLETE;

                                }
                            }
                        }

                    }
                  
                    for (var i in obj) {
                        if (type_name == 'staff') {
                            var fullname = obj[i].name;
                            var length_name = fullname.indexOf(' ');
                            var firstname = fullname.substring(0, length_name);
                            var subname = fullname.substring(length_name + 1, fullname.length);

                            obj[i].name = firstname + '.' + subname.substring(0, 1);
                            obj[i].name_sub = subname;
                            obj[i].fullname = fullname;
                        }
                        for (var x in obj[i].data) {
                            var data_main = obj[i].data;
                            var sum_percent = (((data_main[x] == null) ? 0 : data_main[x] / arr_total_month[x]) * 100);
                            obj[i].data[x] = isNaN(sum_percent) == true ? 0 : sum_percent;
                        }


                    }


                }


                apply();
                return obj;
            }

            function apply() {
                if ($scope.$root.$$phase != '$apply' && $scope.$root.$$phase != '$digest') {
                    $scope.$apply();
                }
            };

            function get_apex_bar_chart(chart_name, type_number, xtype) {
                var set_position = "bottom";
                var istack = true;
                var xmax = 100;
                var color_set = ['#F06292', '#FDD734'];
                var colorset_plan = ['#F06292', '#FDD734'];
                var colorset_unit_fill = [];
                var icheck_list = 4;
                var heightZ = 420;
                var xtextXaix = moment.monthsShort();

                var type_name = $scope.idp_chart_type;
                var dataseries = null;

                var Labels_offsetY = -15;
                //หา total
                var total = null;

                var grid_def = null;

                if (type_number == 4) {
                    //กรณี AGAINT PLAN BY JOB ROLE
                    var xcolumnWidth = '50%'
                    var data_d = $scope.idp_by_jobroles;
                    var data_x = get_data_binde_chart_jr(data_d, xtype);

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

                    xtextXaix = ['Senior', 'Supervisor', 'Junior'];

                    //sumtotal  
                    var data_d = data_x.map(function (d, i) {
                        var role = xtextXaix[i];
                        var total = $scope.idp_by_jobroles.filter(function (d) { return d.BY_TYPE_NAME == role }).reduce(function (a, b) {
                            return (a + b.PLANS_COMPLETE)
                        }, 0);
                        var push_d = (d / total) * 100;
                        return +push_d.toFixed(0)
                    });

                    color_set = ['#00E396', '#FEB019', '#FF4560'];

                    var dataseries = [{
                        name: "Completed",
                        xtotal: total,
                        data: data_d
                    }];

                    //heightZ = "412";

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

                                            if (val == "NaN") { return "" } else { return val + " %" }
                                            val = val + "%";
                                        }
                                    }

                                }
                            }

                            return val;
                        },

                        offsetY: Labels_offsetY,

                        offsetX: 0,

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
                                //fontFamily: 'Helvetica, Arial, sans-serif',
                                fontFamily: 'Montserrat, sans-serif',
                                //cssClass: 'apexcharts-xaxis-label',
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
                                if (xvalue == "NaN") { return "" } else { return xvalue + " %" }

                            },
                        },

                    },
                    grid: grid_def,
                    legend: {
                        show: true,
                        position: set_position,
                        markers: {
                            //fillColors: ['#2494CC', "#ffffff", '#00E396', "#ffffff", '#FEB019', "#ffffff", '#FF4560', "#ffffff"]
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
                $(window).on("resize", function () {

                }).resize();

            }
            function get_data_binde_chart_jr(data, xtype, xdef) {

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

                    var job_role = ['Senior', 'Supervisor', 'Junior'];
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

                            if (type_name == 'staff') {
                                var nameS = d.TYPE_NAME == null ? 'N/A' : d.TYPE_NAME;
                            } else {
                                var nameS = d.TYPE_CODE == null ? 'N/A' : d.TYPE_CODE;
                            }
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

                        var d_type = ['Senior', 'Senior total', 'Supervisor', 'Supervisor total', 'Junior', 'Junior total'];
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

                            var nameS = "";
                            if (type_name == 'staff') {
                                nameS = data[x].TYPE_NAME;
                            } else {
                                nameS = data[x].TYPE_CODE;
                            }
                            if (obj[i].name == nameS) {

                                var month_index = (data[x].MONTH - 1);
                                var vcomplete = (data[x].VALUES_COMPLETE == null) ? 0 : data[x].VALUES_COMPLETE;
                                var vplan = (data[x].PLANS_COMPLETE == null) ? 0 : data[x].PLANS_COMPLETE;
                                var vtotal = vplan - vcomplete;

                                obj[i].data[month_index] += +vcomplete;
                                obj[+i + 1].data[month_index] += (vtotal == null) ? 0 : vtotal; //total plan 
                                arr_total_month[month_index] += (data[x].PLANS_COMPLETE == null) ? 0 : data[x].PLANS_COMPLETE;

                            }

                        }

                    }

                    for (var i in obj) {

                        if (type_name == 'staff') {
                            var fullname = obj[i].name;
                            var length_name = fullname.indexOf(' ');
                            var firstname = fullname.substring(0, length_name);
                            var subname = fullname.substring(length_name + 1, fullname.length);

                            obj[i].name = firstname + '.' + subname.substring(0, 1);
                            obj[i].name_sub = subname;
                            obj[i].fullname = fullname;
                        }

                        for (var x in obj[i].data) {
                            var data_main = obj[i].data;
                            var sum_val = +(((data_main[x] == null) ? 0 : data_main[x] / arr_total_month[x]) * 100);
                            obj[i].data[x] = isNaN(sum_val) == true ? 0 : sum_val;
                        }


                    }
                }

                return obj;
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
                    heightZ = 150;
                    grid_def = {

                        yaxis: {
                            lines: {
                                show: false
                            }
                        },
                        padding: {
                            top: -15,
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
                    var colorset_unit = [];
                    var colorset_unit_fill = [];
                    var icheck_list = 0;
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
                            if (x.name == '5M') {
                                dataseries[i].sort_by = (1);
                                dataseries[i].color_j = colorset_unit[0];
                            }
                            else if (x.name == 'Senior') { dataseries[i].sort_by = (3); dataseries[i].color_j = colorset_unit[1]; }
                            else if (x.name == 'Supervisor') { dataseries[i].sort_by = (4); dataseries[i].color_j = colorset_unit[2]; }
                            else if (x.name == 'Junior') { dataseries[i].sort_by = (5); dataseries[i].color_j = colorset_unit[3]; }
                            else if (x.name == '5M total') {

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
                    else if (type_name == 'staff') {

                        set_position = "right";
                        var Labels_offsetY = 5;
                        var colorset_unit_fill = [];

                        var irow = 0;
                        var color_set = [];
                        var data_type_select = $scope.color_type_emp;//NAME : ชื่อ + สกุล

                        data_type_select.forEach(function (d, s) {
                            dataseries.forEach(function (x, i) {
                                if (x.fullname == d.NAME) {
                                    dataseries[i].sort_by = (s + 1);
                                    dataseries[i].color_j = d.COLOR;
                                    colorset_unit_fill.push(d.COLOR);
                                } else if (x.fullname.replace(" total", "") == d.NAME) {
                                    dataseries[i].sort_by = (s + 1);
                                    dataseries[i].color_j = '#ccc';
                                    colorset_unit_fill.push('#FFFFFF');
                                }

                                for (var ik = 0; ik < datalg.length; ik++) {
                                    if (datalg[ik].NAME == x.fullname) {
                                        dataseries[i].color_j = datalg[ik].COLOR;
                                        break;
                                    } else if (datalg[ik].NAME == x.fullname.replace(" total", "")) {
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
                    else if (type_name == 'team') {

                        var irow = 0;
                        var color_set = [];
                        var colorset_unit_fill = [];
                        var ilst_team = $scope.idp_overall_teams;

                        if ($scope.unit_code_select == 'EOSL-A') {
                            dataseries.forEach(function (x, i) {

                                if (x.name == 'EOSL-A') {

                                    dataseries[i].sort_by = (1);
                                }

                                if (x.name == 'EOSL-A-IM') {

                                    dataseries[i].sort_by = (3);
                                }
                                else if (x.name == 'EOSL-A-RD') { dataseries[i].sort_by = (2); }
                                else if (x.name == 'EOSL-A-ST') { dataseries[i].sort_by = (4); }

                            });

                            var irow = 0;
                            ilst_team.forEach(function (x, i) {
                                irow++;
                                dataseries.forEach(function (a, ir) {

                                    if (x.TEAM_CODE == a.name) {
                                        dataseries[ir].sort_by = (irow);
                                        dataseries[ir].color_j = x.color;
                                        colorset_unit_fill.push(x.color);
                                    } else if (x.TEAM_CODE == a.name.replace(" total", "")) {
                                        dataseries[ir].sort_by = (irow);
                                        dataseries[ir].color_j = '#ccc';
                                        colorset_unit_fill.push('#FFFFFF');
                                    }

                                    for (var ik = 0; ik < datalg.length; ik++) {
                                        if (datalg[ik].NAME == a.name) {
                                            dataseries[ir].color_j = datalg[ik].COLOR;
                                            break;
                                        } else if (datalg[ik].NAME == a.name.replace(" total", "")) {
                                            dataseries[ir].color_j = "#CCC";
                                            break;
                                        }
                                    }

                                });
                            });

                            dataseries.sort(function (a, b) { return a.sort_by - b.sort_by });
                            color_set = dataseries.map(function (a) { return a.color_j });
                            color_set.push('#FFFFFF');
                            colorset_unit_fill.push('#FFFFFF');

                        }
                        else {

                            var irow = 0;
                            ilst_team.forEach(function (x, i) {

                                irow++;
                                dataseries.forEach(function (a, ir) {

                                    if (x.TEAM_CODE == a.name) {
                                        dataseries[ir].sort_by = (irow);
                                        dataseries[ir].color_j = x.color;
                                        colorset_unit_fill.push(x.color);
                                    } else if (x.TEAM_CODE == a.name.replace(" total", "")) {
                                        dataseries[ir].sort_by = (irow);
                                        dataseries[ir].color_j = '#ccc';
                                        colorset_unit_fill.push('#FFFFFF');
                                    }

                                    for (var ik = 0; ik < datalg.length; ik++) {
                                        if (datalg[ik].NAME == x.TEAM_CODE) {
                                            dataseries[ir].color_j = datalg[ik].COLOR;
                                            break;
                                        } else if (datalg[ik].NAME == x.TEAM_CODE.replace(" total", "")) {
                                            dataseries[ir].color_j = "#CCC";
                                            break;
                                        }
                                    }

                                });
                            });

                            dataseries.sort(function (a, b) { return a.sort_by - b.sort_by });
                            color_set = dataseries.map(function (a) { return a.color_j });
                            color_set.push('#FFFFFF');
                            colorset_unit_fill.push('#FFFFFF');

                        }

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

                        if (type_name == 'staff') {
                            if (dataseries[i].name_sub.indexOf(" total") > -1) {
                                if (dataseries_copy_total.length == 0) {
                                    dataseries_copy_total.push(angular.copy(dataseries[i]));
                                } else {
                                    dataseries_copy_total[0].sort_by = 99;
                                    dataseries_copy_total[0].name = "Total";
                                    dataseries_copy_total[0].name_sub = "Total";
                                    dataseries_copy_total[0].fullname = "Total";
                                    for (var j = 0; j < 12; j++) {
                                        dataseries_copy_total[0].data[j] += +dataseries[i].data[j];
                                    }
                                }
                            } else if (dataseries[i].name == null) {

                            } else {
                                dataseries_copy.push(angular.copy(dataseries[i]));
                            }

                        } else {
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
                    }

                    console.log("dataseries to dataseries_copy_total ");
                    console.log(dataseries_copy_total);

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
                    var job_role = ['Senior', 'Supervisor', 'Junior'];
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

                    var d_type = ['Senior', 'Senior total', 'Supervisor', 'Supervisor total', 'Junior', 'Junior total'];
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
                        try {
                            var data = data.filter(function (x) {
                                return (
                                    (x.TYPE_NAME == xfillter_val[0] && xfillter_val[0] != "")
                                    || (x.TYPE_NAME == xfillter_val[1] && xfillter_val[1] != "")
                                    || (x.TYPE_NAME == xfillter_val[2] && xfillter_val[2] != "")
                                    || (x.TYPE_NAME == xfillter_val[3] && xfillter_val[3] != "")
                                    || (x.TYPE_NAME == xfillter_val[4] && xfillter_val[4] != "")
                                    || (x.TYPE_NAME == xfillter_val[5] && xfillter_val[5] != "")
                                    || (x.TYPE_NAME == xfillter_val[6] && xfillter_val[6] != "")
                                    || (x.TYPE_NAME == xfillter_val[7] && xfillter_val[7] != "")
                                    || (x.TYPE_NAME == xfillter_val[8] && xfillter_val[8] != "")
                                    || (x.TYPE_NAME == xfillter_val[9] && xfillter_val[9] != "")
                                    || (x.TYPE_NAME == xfillter_val[10] && xfillter_val[10] != "")
                                    || (x.TYPE_NAME == xfillter_val[11] && xfillter_val[11] != "")
                                    || (x.TYPE_NAME == xfillter_val[12] && xfillter_val[12] != "")
                                    || (x.TYPE_NAME == xfillter_val[13] && xfillter_val[13] != "")
                                    || (x.TYPE_NAME == xfillter_val[14] && xfillter_val[14] != "")
                                    || (x.TYPE_NAME == xfillter_val[15] && xfillter_val[15] != "")
                                    || (x.TYPE_NAME == xfillter_val[16] && xfillter_val[16] != "")
                                    || (x.TYPE_NAME == xfillter_val[17] && xfillter_val[17] != "")
                                    || (x.TYPE_NAME == xfillter_val[18] && xfillter_val[18] != "")
                                    || (x.TYPE_NAME == xfillter_val[19] && xfillter_val[19] != "")
                                    || (x.TYPE_NAME == xfillter_val[20] && xfillter_val[20] != ""))
                            });
                        } catch{ }
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

                            if (type_name == 'staff') {
                                var nameS = d.TYPE_NAME == null ? 'N/A' : d.TYPE_NAME;
                            } else {
                                var nameS = d.TYPE_CODE == null ? 'N/A' : d.TYPE_CODE;
                            }
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

                            var nameS = "";
                            if (type_name == 'staff') {
                                nameS = data[x].TYPE_NAME;
                            } else {
                                nameS = data[x].TYPE_CODE;
                            }
                            if (obj[i].name == nameS) {

                                var month_index = (data[x].MONTH - 1);
                                var vcomplete = (data[x].VALUES_COMPLETE == null) ? 0 : data[x].VALUES_COMPLETE;
                                var vplan = (data[x].PLANS_COMPLETE == null) ? 0 : data[x].PLANS_COMPLETE;
                                var vtotal = vplan - vcomplete;

                                obj[i].data[month_index] += +vcomplete;
                                obj[+i + 1].data[month_index] += (vtotal == null) ? 0 : vtotal; //total plan 
                                arr_total_month[month_index] += (data[x].PLANS_COMPLETE == null) ? 0 : data[x].PLANS_COMPLETE;

                            }

                        }

                    }

                    for (var i in obj) {

                        if (type_name == 'staff') {
                            var fullname = obj[i].name;
                            var length_name = fullname.indexOf(' ');
                            var firstname = fullname.substring(0, length_name);
                            var subname = fullname.substring(length_name + 1, fullname.length);

                            obj[i].name = firstname + '.' + subname.substring(0, 1);
                            obj[i].name_sub = subname;
                            obj[i].fullname = fullname;
                        }

                        for (var x in obj[i].data) {
                            var data_main = obj[i].data;
                            var sum_val = +(((data_main[x] == null) ? 0 : data_main[x] / arr_total_month[x]) * 100);
                            obj[i].data[x] = isNaN(sum_val) == true ? 0 : sum_val;
                        }


                    }
                }

                return obj;
            }

            function data_to_chart_gap_again(bool) {
                if (bool == true) {
                    $('#chart_idp_plan').html('');
                    $('#chart_gap_plan').html('');
                }

                //Auwat Start  
                $scope.fillter_type_chart_idp = "";
                $scope.fillter_type_chart_gap = "";
                var chart_type = $scope.idp_chart_type; // idp_chart_type-- > type, jobrole, unit, staff
                if (chart_type == "type") {

                    $scope.listjobroles_idp = $scope.dtidp_totals.map(function (d, i) {
                        var color_select = $scope.arr_css_style2[i];
                        return { COLOR: color_select, NAME: d.TYPE_NAME, STATUS: true }
                    });

                } else if (chart_type == "jobrole") {
                    $scope.listjobroles_idp = [{ "COLOR": "#00E396", "NAME": "Senior", "STATUS": true }];
                    $scope.listjobroles_idp.push({ "COLOR": "#FEB019", "NAME": "Supervisor", "STATUS": true });
                    $scope.listjobroles_idp.push({ "COLOR": "#FF4560", "NAME": "Junior", "STATUS": true });

                } else if (chart_type == "unit") {
                    $scope.listjobroles_idp = [{ "COLOR": "#ff5722", "NAME": "EOSL", "STATUS": true }];
                    $scope.listjobroles_idp.push({ "COLOR": "#FFB638", "NAME": "EOSL-A", "STATUS": true });
                    $scope.listjobroles_idp.push({ "COLOR": "#70FFDA", "NAME": "EOSL-B", "STATUS": true });
                    $scope.listjobroles_idp.push({ "COLOR": "#2196F3", "NAME": "EOSL-C", "STATUS": true });
                    $scope.listjobroles_idp.push({ "COLOR": "#009688", "NAME": "EOSL-E", "STATUS": true });
                    $scope.listjobroles_idp.push({ "COLOR": "#FF4081", "NAME": "EOSL-F", "STATUS": true });

                } else if (chart_type == "staff") {

                    $scope.listjobroles_idp = $scope.color_type_emp.map(function (d, i) {
                        var str = d.NAME;
                        var res = str.split(" ");
                        var short_name = res[0] + ' ' + res[1].substring(0, 1) + '.';
                        return { COLOR: d.COLOR, NAME: d.NAME, STATUS: true, SHORT_NAME: short_name }
                    });

                } else if (chart_type == "team") {

                    $scope.listjobroles_idp = $scope.idp_overall_teams.map(function (d, i) {
                        return { COLOR: d.COLOR, NAME: d.TEAM_CODE, STATUS: true }
                    });

                }
                $scope.listjobroles_gap = angular.copy($scope.listjobroles_idp);
                //Auwat End

                var id_s = "chart_idp_plan";
                get_apex_bar_chart_switch(id_s, 1, 'againt_plan');
                var id_s = "chart_gap_plan";
                get_apex_bar_chart_switch(id_s, 1, 'gap_closing');

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
