<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DTusingClass.aspx.cs" Inherits="EmployeeManagement.DTusingClass" %>
	<!DOCTYPE html>
	<html>

	<head runat="server">
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.0/css/bootstrap.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-rc.0/css/select2.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.13.3/css/selectize.bootstrap3.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.9/flatpickr.min.css">
		<link rel="stylesheet" href="https://cdn.datatables.net/1.11.1/css/jquery.dataTables.min.css">
		<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.dataTables.min.css">
		<link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.7.1/css/buttons.dataTables.min.css">
		<link rel="stylesheet" href="https://cdn.datatables.net/searchpanes/1.4.0/css/searchPanes.dataTables.min.css">
		<link rel="stylesheet" href="https://cdn.datatables.net/select/1.3.3/css/select.dataTables.min.css">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>DTusingClass</title>
		<style>
		form {
			top: 25px !important;
			position: relative !important;
		}
		
		.card {
			box-shadow: 4px 4px 8px 4px rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19) !important;
			text-align: center !important;
		}
		
		input[type=number]::-webkit-inner-spin-button,
		input[type=number]::-webkit-outer-spin-button {
			-webkit-appearance: none;
			margin: 0;
		}
		
		.exportbtncolor {
			background-color: #264653 !important;
			color: white !important;
		}
		
		.copybtncolor {
			background-color: #2A9D8F !important;
			color: white !important;
		}
		
		.printbtncolor {
			background-color: #E9C46A !important;
			color: white !important;
		}
		
		.searchbtncolor {
			background-color: #E76F51 !important;
			color: white !important;
		}
		
		.tip {
			position: relative;
			display: inline-block;
		}
		
		.color1 {
			height: 25px;
			width: 25px;
			background-color: grey;
			border-radius: 50%;
			display: inline-block;
		}
		
		.color2 {
			height: 25px;
			width: 25px;
			background-color: #f4e285;
			border-radius: 50%;
			display: inline-block;
		}
		
		.color3 {
			height: 25px;
			width: 25px;
			background-color: #F77F00;
			border-radius: 50%;
			display: inline-block;
		}
		
		.color4 {
			height: 25px;
			width: 25px;
			background-color: #606C38;
			border-radius: 50%;
			display: inline-block;
		}
		
		.color5 {
			height: 25px;
			width: 25px;
			background-color: #80ffdb;
			border-radius: 50%;
			display: inline-block;
		}
		
		.color6 {
			height: 25px;
			width: 25px;
			background-color: #8338ec;
			border-radius: 50%;
			display: inline-block;
		}
		
		.color7 {
			height: 25px;
			width: 25px;
			background-color: #ff5d8f;
			border-radius: 50%;
			display: inline-block;
		}
		
		#ecdept,
		#eedept {
			width: 160px !important;
		}
		
		input[type=number]:valid {
			border-color: green;
			border-width: 2.2px;
		}
		
		input[type=number]:invalid {
			border-color: red;
			border-width: 2.2px;
		}
		
		input[type=text]:valid {
			border-color: green;
			border-width: 2.2px;
		}
		
		input[type=text]:invalid {
			border-color: red;
			border-width: 2.2px;
		}
		
		select:valid {
			border-color: green;
			border-width: 2.2px;
		}
		
		select:invalid {
			border-color: red;
			border-width: 2.2px;
		}
		
		select:invalid + .select2-container > span.selection > span.select2-selection {
			border-color: red;
			border-width: 2.2px;
		}
		
		select:valid + .select2-container > span.selection > span.select2-selection {
			border-color: green;
			border-width: 2.2px;
		}
		
		.dataTables_scroll {
			overflow: auto;
		}
		
		.tooltip-inner {
			padding-left: 20px !important;
			max-width: 500px !important;
			background: white;
		}
		
		.form-control:focus,
		select:focus {
			border-color: inherit;
			-webkit-box-shadow: none;
			box-shadow: none;
		}
		</style>
	</head>

	<body>
		<form id="form1" runat="server">
			<div class="container-fluid">
				<div class="modal fade" id="ecreatemodal" data-backdrop="static">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">Enter Employee Details</h4>
								<button type="button" class="close" data-dismiss="modal" onclick="reset()">&times;</button>
							</div>
							<div class="modal-body m-2">
								<div class="row mb-4">
									<label class="col-form-label">Name:</label>
									<div class="col">
										<input type="text" id="ecname" class="form-control" runat="server" required> </div>
									<label class="col-form-label">Phone:</label>
									<div class="col">
										<input type="number" id="ecphone" class="form-control" runat="server" required> </div>
								</div>
								<div class="row mb-4">
									<label class="col-form-label">Dept:</label>
									<div class="col pl-4">
										<select id="ecdept" class="form-control" multiple="true" runat="server" required></select>
									</div>
									<label class="col-form-label">Subject:</label>
									<div class="col">
										<input type="text" id="ecsubject" class="form-control" runat="server" required> </div>
								</div>
								<div class="row mb-4">
									<label class="col-form-label">City:</label>
									<div class="col-5 ml-2">
										<select id="eccity" class="form-control" runat="server" required></select>
									</div>
									<label class="col-form-label">Time:</label>
									<div class="col-5">
										<input id="empjoiningtime" class="flatpickr flatpickr-input form-control" autofocus runat="server" required> </div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-success" onclick="ecvalidation()" runat="server">Add</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="eeditmodal" data-backdrop="static">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">Edit Employee Details</h4>
								<button type="button" class="close" data-dismiss="modal" onclick="reset()">&times;</button>
							</div>
							<div class="modal-body m-2">
								<div class="row mb-4">
									<div class="col-sm-6">
										<label>Name</label>
										<input type="text" id="eenametext" class="form-control" runat="server" required> </div>
									<div class="col-sm-6">
										<label>Phone</label>
										<input type="number" id="eephone" class="form-control" runat="server" required> </div>
								</div>
								<div class="row mb-4">
									<div class="col-sm-6">
										<label>Dept</label>
										<select id="eedept" class="form-control" multiple="true" data-width="100%" runat="server" required></select>
									</div>
									<div class="col-sm-6">
										<label>Subject</label>
										<input type="text" id="eesubject" class="form-control" runat="server" required> </div>
								</div>
								<div class="row">
									<div class="col-sm-6">
										<label>City</label>
										<select id="eecity" class="form-control" runat="server"></select>
									</div>
									<div class="col-sm-6">
										<label>Time</label>
										<input id="eetime" class="flatpickr flatpickr-input form-control" autofocus runat="server" required> </div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="reset()" runat="server">Close</button>
								<button type="button" class="btn btn-warning" onclick="eedit()" runat="server">Update</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="edeletemodal" data-backdrop="static">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">Delete Employee</h4>
								<button type="button" class="close" data-dismiss="modal" onclick="reset()">&times;</button>
							</div>
							<div class="modal-body m-2">
								<div class="row mb-4">
									<label class="col-form-label">Name:</label>
									<div class="col">
										<input type="text" id="ednametext" class="form-control" runat="server" disabled> </div>
									<label class="col-form-label">Phone:</label>
									<div class="col">
										<input type="number" id="edphone" class="form-control" runat="server" disabled> </div>
								</div>
								<div class="row mb-4">
									<label class="col-form-label">Dept:</label>
									<div class="col">
										<input type="text" id="eddept" class="form-control" runat="server" disabled> </div>
									<label class="col-form-label">Subject:</label>
									<div class="col">
										<input type="text" id="edsubject" class="form-control" runat="server" disabled> </div>
								</div>
								<div class="row mb-4">
									<label class="col-form-label">City:</label>
									<div class="col">
										<input type="text" id="edcity" class="form-control" runat="server" disabled> </div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" onclick="edelete()" runat="server">Delete</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="dcreatemodal" data-backdrop="static">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">Enter Department Details</h4>
								<button type="button" class="close" data-dismiss="modal" onclick="modal()">&times;</button>
							</div>
							<div class="modal-body m-2">
								<div class="row mb-4">
									<label class="col-form-label">Name:</label>
									<div class="col">
										<input type="text" id="dcname" class="form-control" runat="server" required> </div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-success" onclick="dcvalidation()" runat="server">Add</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="ddeletemodal" data-backdrop="static">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">Delete Department</h4>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
							<div class="modal-body m-2">
								<div class="row mb-4">
									<label class="col-form-label">Name:</label>
									<div class="col">
										<select id="ddname" class="form-control" onchange="deptdelchangecolor()" runat="server"></select>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" onclick="ddelete()" runat="server">Delete</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="ccreatemodal" data-backdrop="static">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">Enter City Details</h4>
								<button type="button" class="close" data-dismiss="modal" onclick="modal()">&times;</button>
							</div>
							<div class="modal-body m-2">
								<div class="row mb-4">
									<label class="col-form-label">City Name:</label>
									<div class="col">
										<input type="text" id="ccname" class="form-control" runat="server" required> </div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-success" onclick="ccvalidation()" runat="server">Add</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="cdeletemodal" data-backdrop="static">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">Delete City</h4>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
							<div class="modal-body m-2">
								<div class="row mb-4">
									<label class="col-form-label">Name:</label>
									<div class="col">
										<select id="cdname" class="form-control" onchange="citydelchangecolor()" runat="server"></select>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" onclick="cdelete()" runat="server">Delete</button>
							</div>
						</div>
					</div>
				</div>
				<div class="card tab-content">
					<div class="card-header text-left p-1" id="cardheader">
						<button type="button" id="eadd" onclick="addemp()" class="btn btn-default btn-success"><span class="fas fa-plus"></span> Employee</button>
						<button type="button" id="dadd" onclick="adddept()" class="btn btn-default btn-success"><span class="fas fa-plus"></span> Department</button>
						<button type="button" id="cadd" onclick="addcity()" class="btn btn-default btn-success"><span class="fas fa-plus"></span> City</button>
						<button type="button" id="ddel" onclick="deletedept()" class="btn btn-default btn-danger"><span class="fas fa-trash"></span> Department</button>
						<button type="button" id="cdel" onclick="deletecity()" class="btn btn-default btn-danger"><span class="fas fa-trash"></span> City</button>
						<button type="button" id="refresh" onclick="refreshbtn()" class="btn btn-default btn-info"><span class="fas fa-sync-alt"></span> Refresh</button>
						<div id="infobtn" class="btn btn-secondary" data-toggle="tooltip" style="float: right;" data-html="true"><i class="fas fa-info"></i> Legend</div>
					</div>
					<div class="card-body container-fluid">
						<table id="tableid" class="table table-bordered">
							<tr id="tr"></tr>
						</table>
					</div>
				</div>
			</div>
		</form>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.13.3/js/standalone/selectize.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.0/js/bootstrap.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.1.0-rc.0/js/select2.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.9/flatpickr.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.5/dist/sweetalert2.all.min.js"></script>
		<script src="https://cdn.datatables.net/1.11.1/js/jquery.dataTables.min.js"></script>
		<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
		<script src="https://cdn.datatables.net/searchpanes/1.4.0/js/dataTables.searchPanes.min.js"></script>
		<script src="https://cdn.datatables.net/buttons/1.7.1/js/dataTables.buttons.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.7.1/jszip.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.2/pdfmake.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.2/vfs_fonts.js"></script>
		<script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.html5.min.js"></script>
		<script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.print.min.js"></script>
		<script src="https://cdn.datatables.net/buttons/1.7.1/js/buttons.colVis.min.js"></script>
		<script src="https://cdn.datatables.net/select/1.3.3/js/dataTables.select.min.js"></script>
		<script>
            $(document).ready(function () {
                debugger
                reset();
                $('#ecdept').select2();
                $('#eedept').select2();
                $("#ddname").css({
                    "border-color": "red",
                    "border-width": "2.2px"
                });
                $("#cdname").css({
                    "border-color": "red",
                    "border-width": "2.2px"
                });
                $('[data-toggle="undodeptname"]').tooltip();
                $("#infobtn").tooltip({
                    title: '<div class="row"><div class="col-sm-1 color1"></div><pre style="color:red;"> - Employee is inactive</pre> <br> <br> </div><div class="row"><div class= "col-sm-1 color2"></div><pre style="color:red;"> - Department is inactive</pre> <br> <br> </div><div class="row"><div class="col-sm-1 color3"></div><pre style="color:red;"> - City is inactive</pre> <br> <br> </div><div class="row"><div class= "col-sm-1 color4"></div><pre style="color:red;"> - Both Employee and Department are inactive</pre> <br> <br> </div><div class="row"><div class= "col-sm-1 color5"></div><pre style="color:red;"> - Both Employee and City are inactive</pre> <br> <br> </div><div class="row"><div class="col-sm-1 color6"></div><pre style="color:red;"> - Both Department and City are inactive</pre> <br> <br> </div><div class="row"><div class="col-sm-1 color7"></div><pre style="color:red;"> - Employee, Department and City are inactive</pre></div></div>',
                    html: true,
                });
                table();
            });

            function refreshbtn() {
                debugger
                table();
            }

            function reset() {
                debugger
                document.getElementById("form1").reset();
            }

            function deptdelchangecolor() {
                debugger
                $("#ddname").css({
                    "border-color": "green",
                    "border-width": "2.2px"
                });
            }

            function citydelchangecolor() {
                debugger
                $("#cdname").css({
                    "border-color": "green",
                    "border-width": "2.2px"
                });
            }

            function table() {
                debugger
                $.ajax({
                    type: "POST",
                    url: "DTusingClass.aspx/Table",
                    contentType: "application/json; charset=utf-8",
                    beforeSend: function () {
                        $('#tr').html("LOADING....");
                    },
                    success: function (result) {
                        debugger
                        var json = JSON.parse(result.d);
                        if (!$.fn.DataTable.isDataTable('#tableid')) {
                            $("#tableid").DataTable({
                                "responsive": true,
                                "bScrollCollapse": true,
                                "autoWidth": false,
                                "order": [0, "asc"],
                                "data": json,
                                dom: '<"row"<"col-xl-2 col-lg-12 col-md-12 col-sm-12"P><"col-xl-10 col-lg-12 col-md-12 col-sm-12"frtipl>>',
                                "columns": [{
                                    "data": "emp_name",
                                    title: "Employee Name"
                                }, {
                                    "data": "phone",
                                    title: "Phone"
                                }, {
                                    "data": "subject",
                                    title: "Subject"
                                }, {
                                    "data": "is_active",
                                    title: "Is Active"
                                }, {
                                    "data": "dept_name",
                                    title: "Department",
                                    "render": function (data, type, row) {
                                        if (type === 'sp') {
                                            if (data != null && data.includes(",")) {
                                                return data.split(",");
                                            } else {
                                                return data;
                                            }
                                        }
                                        return data;
                                    },
                                    "searchPanes": {
                                        orthogonal: "sp",
                                        show: true
                                    },
                                }, {
                                    "data": "city_name",
                                    title: "City"
                                }, {
                                    "data": "emp_joining_time",
                                    title: "Joining Time",
                                    "type": "date"
                                }, {
                                    "data": "buttons",
                                    title: "Buttons"
                                }, {
                                    "data": "dept_is_deleted",
                                    title: "Dept_is_Deleted"
                                }, {
                                    "data": "city_is_deleted",
                                    title: "City_is_Deleted"
                                },],
                                "buttons": [{
                                    extend: 'collection',
                                    text: '<i class="fas fa-download"> Export</i>',
                                    className: 'btn btn-default btn-success exportbtncolor',
                                    buttons: [{
                                        extend: 'csv',
                                        title: 'Employee Details',
                                        text: '<i class="fas fa-file-csv"> CSV</i>',
                                        className: 'exportbtncolor',
                                        exportOptions: {
                                            columns: [0, 1, 2, 3, 4, 5, 6]
                                        },
                                    }, {
                                        extend: 'excel',
                                        title: 'Employee Details',
                                        text: '<i class="fas fa-file-excel"> EXCEL</i>',
                                        className: 'exportbtncolor',
                                        exportOptions: {
                                            columns: [0, 1, 2, 3, 4, 5, 6]
                                        },
                                    }, {
                                        extend: 'pdf',
                                        title: 'Employee Details',
                                        text: '<i class="fas fa-file-pdf"> PDF</i>',
                                        className: 'exportbtncolor',
                                        exportOptions: {
                                            columns: [0, 1, 2, 3, 4, 5, 6]
                                        },
                                    },],
                                }, {
                                    extend: 'copy',
                                    text: '<i class="fas fa-copy"> Copy</i>',
                                    className: 'copybtncolor',
                                }, {
                                    extend: 'print',
                                    text: '<i class="fas fa-print"> Print</i>',
                                    className: 'printbtncolor',
                                    exportOptions: {
                                        columns: [0, 1, 2, 3, 4, 5, 6]
                                    },
                                },],
                                searchPanes: {
                                    controls: false,
                                    dtOpts: {
                                        select: {
                                            style: 'multi'
                                        }
                                    },
                                    panes: [{
                                        header: 'Is Active',
                                        options: [{
                                            label: 'Yes',
                                            value: function (rowData, rowIdx) {
                                                debugger
                                                return rowData["is_active"] == "y";
                                            },
                                        }, {
                                            label: 'No',
                                            value: function (rowData, rowIdx) {
                                                return rowData["is_active"] == "n";
                                            },
                                        }],
                                    }],
                                },
                                columnDefs: [{
                                    searchPanes: {
                                        show: true
                                    },
                                    targets: [0, 4, 5]
                                }, {
                                    searchPanes: {
                                        show: false
                                    },
                                    targets: [1, 2, 3, 6, 7, 8, 9]
                                }, {
                                    "targets": [8, 9],
                                    "visible": false
                                }, {
                                    orderable: false,
                                    targets: 7
                                },],
                                drawCallback: function () {
                                    var rows = this.api().rows({
                                        filter: 'applied'
                                    }).data().length;
                                    if (rows == 0) {
                                        $("#tableid").DataTable().button(2).disable();
                                    } else {
                                        $("#tableid").DataTable().button(2).enable();
                                    }
                                    $.each($("#tableid tr"), function () {
                                        debugger
                                        var rowCount = $("#tableid tr th").length;
                                        var text1 = $(this).find('td').eq(8).text();
                                        var text = $(this).find('td').eq(7).text().split(" ").join("");
                                        if (text == 'Emp') {
                                            $(this).css('background-color', 'grey');
                                        }
                                        if (text == 'EmpEmpDept' || text == 'EmpEmpDeptDept' || text == 'EmpEmpDeptDeptDept') {
                                            $(this).css('background-color', '#f4e285');
                                        }
                                        if (text == 'EmpEmpCity') {
                                            $(this).css('background-color', '#F77F00');
                                        }
                                        if (text == 'EmpDept' || text == 'EmpDeptDept') {
                                            $(this).css('background-color', '#606C38');
                                        }
                                        if (text == 'EmpCity') {
                                            $(this).css('background-color', '#80ffdb');
                                        }
                                        if (text == 'EmpEmpDeptCity' || text == 'EmpEmpCityDept' || text == 'EmpEmpCityDeptDept') {
                                            $(this).css('background-color', '#8338ec');
                                        }
                                        if (text == 'EmpDeptCity' || text == 'EmpCityDept' || text == 'EmpCityDeptDept' || text == 'EmpDeptDeptCity') {
                                            $(this).css('background-color', '#ff5d8f');
                                        }
                                    });
                                },
                            });
                            $("#tableid").DataTable().buttons().container().appendTo($('#cardheader'));
                            $("#tableid_length").insertBefore("#tableid");
                        } else {
                            debugger
                            $("#tableid").DataTable().clear();
                            $('#tableid tbody:first').before('<tr class="trr"></tr>');
                            $('.trr').html("LOADING....");
                            $("#tableid").DataTable().rows.add(json).draw();
                            $(".trr").show();
                        }
                    },
                    complete: function () {
                        $("#tr").toggle();
                        setTimeout(function () {
                            $(".trr").remove();
                        }, 2000);
                    }
                });
            }
            var deptidbefore = "";
            var deptbtnremove = [];

            function edeptdropdown(dept) {
                debugger
                $.ajax({
                    type: "POST",
                    url: "DTusingClass.aspx/Ddropdown",
                    contentType: "application/json; charset=utf-8",
                    success: function (result) {
                        debugger
                        var data = JSON.parse(result.d);
                        if (dept == null) {
                            var s = '<option selected value="0" disabled>Choose one</option>';
                            for (i = 0; i < data.length; i = i + 3) {
                                s += '<option value=' + data[i] + '>' + data[i + 1] + '</option>';
                                $("#ecdept").html(s);
                                $("#eedept").html(s);
                                $("#ddname").html(s);
                                $('#ecdept option').attr('selected', false);
                            }
                        } else {
                            debugger
                            var s = '';
                            var selected = "";
                            var deptlength = dept.split(",").length;
                            for (i = 0; i < data.length; i = i + 3) {
                                for (j = 0; j < deptlength; j++) {
                                    if (data[i + 1] == dept.split(',')[j]) {
                                        if (data[i + 2] == 1) {
                                            s += '<option selected value=' + data[i] + ' disabled>' + data[i + 1] + '</option>';
                                            deptbtnremove.push(data[i + 1]);
                                        } else {
                                            s += '<option selected value=' + data[i] + '>' + data[i + 1] + '</option>';
                                            deptbtnremove.pop(data[i + 1]);
                                        }
                                        j = deptlength;
                                        selected = 1;
                                    }
                                }
                                if (selected == "0") {
                                    if (data[i + 2] == 1) {
                                        s += '<option value=' + data[i] + ' disabled>' + data[i + 1] + '</option>';
                                    } else {
                                        s += '<option value=' + data[i] + '>' + data[i + 1] + '</option>';
                                    }
                                }
                                $("#eedept").html(s);
                                selected = 0;
                            }
                        }
                        debugger
                        deptidbefore = $("#eedept").val();
                    }
                });
                debugger
                setTimeout(function () {
                    for (var i = 0; i < deptbtnremove.length; i++) {
                        $('.select2-selection__choice[title="' + deptbtnremove[i] + '"] > .select2-selection__choice__remove').remove()
                    }
                }, 50);
            }

            function ecitydropdown(city) {
                $.ajax({
                    type: "POST",
                    url: "DTusingClass.aspx/Cdropdown",
                    contentType: "application/json; charset=utf-8",
                    success: function (result) {
                        debugger
                        var data = JSON.parse(result.d);
                        if (city == null) {
                            var s = '<option selected value="" disabled>Choose one</option>';
                            for (i = 0; i < data.length; i = i + 3) {
                                s += '<option value=' + data[i] + '>' + data[i + 1] + '</option>';
                                $("#eccity").html(s);
                                $("#eecity").html(s);
                                $("#cdname").html(s);
                            }
                            $('#cdname').selectize({});
                        } else {
                            var s = '<option selected value="0" disabled>Choose one</option>';
                            for (i = 0; i < data.length; i = i + 3) {
                                if (data[i + 1] == city) {
                                    if (data[i + 2] == 1) {
                                        s += '<option selected value=' + data[i] + ' disabled>' + data[i + 1] + '</option>';
                                    } else {
                                        s += '<option selected value=' + data[i] + '>' + data[i + 1] + '</option>';
                                    }
                                } else {
                                    if (data[i + 2] == 1) {
                                        s += '<option value=' + data[i] + ' disabled>' + data[i + 1] + '</option>';
                                    } else {
                                        s += '<option value=' + data[i] + '>' + data[i + 1] + '</option>';
                                    }
                                }
                                $("#eccity").html(s);
                                $("#eecity").html(s);
                            }
                        }
                    }
                });
            }

            function addemp() {
                debugger
                $('#ecreatemodal').modal('show');
                edeptdropdown();
                ecitydropdown();
                var date = new Date();
                $('#empjoiningtime').flatpickr({
                    enableTime: true,
                    dateFormat: "m-d-Y G:i K",
                    defaultDate: date,
                    maxDate: date,
                });
            }

            function ecvalidation() {
                debugger
                var ecnametext = document.getElementById("ecname").value;
                var ecphone = document.getElementById("ecphone").value;
                var ecdept = $("#ecdept").find('option:selected').text();
                var ecsubject = document.getElementById("ecsubject").value;
                var eccity = $("#eccity").find('option:selected').text();
                if (ecnametext == null || ecnametext == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Name can\'t be blank',
                    })
                    return false;
                } else if (ecphone.length != 10) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Phone number must be 10 characters long',
                    })
                    return false;
                } else if (ecdept == null || ecdept == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Department can\'t be blank',
                    })
                    return false;
                } else if (ecsubject == null || ecsubject == "") {
                    debugger
                    Swal.fire({
                        icon: 'error',
                        title: 'Subject can\'t be blank',
                    })
                    return false;
                } else if (eccity == null || eccity == "Choose one") {
                    Swal.fire({
                        icon: 'error',
                        title: 'City can\'t be blank',
                    })
                    return false;
                } else {
                    Swal.fire({
                        title: 'Do you want to create?',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes',
                        cancelButtonText: 'No',
                    }).then((result) => {
                        if (result.isConfirmed) {
                            debugger
                            var time = $("#empjoiningtime").val();
                            var ecnametext = document.getElementById("ecname").value;
                            var ecphone = document.getElementById("ecphone").value;
                            var ecdeptid = $("#ecdept").val();
                            var ecdeptidcount = $("#ecdept :selected").length;
                            var ecsubject = document.getElementById("ecsubject").value;
                            var eccityid = document.getElementById("eccity").value;
                            var details = {
                                ecnametext: ecnametext,
                                ecphone: ecphone,
                                ecdeptid: ecdeptid,
                                ecdeptidcount: ecdeptidcount,
                                ecsubject: ecsubject,
                                eccityid: eccityid,
                                time: time
                            };
                            var str = JSON.stringify(details);
                            $('#ecreatemodal').modal('hide');
                            $.ajax({
                                type: "POST",
                                url: "DTusingClass.aspx/Ecreate",
                                contentType: "application/json; charset=utf-8",
                                data: str,
                                success: function () {
                                    debugger
                                    reset();
                                    table();
                                    Swal.fire('Employee has been created!', ' ', 'success')
                                }
                            });
                        }
                    })
                }
            }
            var pk = "";
            var eename = "";

            function editbtn(emp_id) {
                debugger
                var details = {
                    emp_id: emp_id
                };
                var str = JSON.stringify(details);
                $.ajax({
                    type: "POST",
                    url: "DTusingClass.aspx/Eeditdetails",
                    contentType: "application/json; charset=utf-8",
                    data: str,
                    success: function (result) {
                        debugger
                        var data = JSON.parse(result.d);
                        pk = data[5];
                        eename = emp_id;
                        edeptdropdown(data[3]);
                        ecitydropdown(data[4]);
                        document.getElementById('eenametext').value = data[0];
                        document.getElementById("eephone").value = data[1];
                        $('#eedept option').attr('selected', false);
                        $('#eedept option:contains("' + data[3] + '")').attr('selected', true);
                        document.getElementById("eesubject").value = data[2];
                        $('#eecity option').attr('selected', false);
                        $('#eecity option:contains("' + data[4] + '")').attr('selected', true);
                        debugger
                        var date = new Date();
                        var d = data[6];
                        $('#eetime').flatpickr({
                            enableTime: true,
                            dateFormat: "m-d-Y G:i K",
                            defaultDate: data[6],
                            maxDate: date,
                        });
                    }
                });
            }

            function eedit() {
                debugger
                $('#eemodal').modal('hide');
                var eenametext = document.getElementById("eenametext").value;
                var eephone = document.getElementById("eephone").value;
                var eedept = $("#eedept").find('option:selected').text();
                var eesubject = document.getElementById("eesubject").value;
                var eecity = $("#eecity").find('option:selected').text();
                if (eenametext == null || eenametext == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Name can\'t be blank',
                    })
                    return false;
                } else if (eephone.length != 10) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Phone number must be 10 characters long',
                    })
                    return false;
                } else if (eedept == null || eedept == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Department can\'t be blank',
                    })
                    return false;
                } else if (eesubject == null || eesubject == "") {
                    debugger
                    Swal.fire({
                        icon: 'error',
                        title: 'Subject can\'t be blank',
                    })
                    return false;
                } else if (eecity == null || eecity == "Choose one") {
                    Swal.fire({
                        icon: 'error',
                        title: 'City can\'t be blank',
                    })
                    return false;
                } else {
                    var date = new Date();
                    Swal.fire({
                        title: 'Do you want to update?',
                        icon: 'warning',
                        html: '<input style="display:none" id="empdeptdeldatetimepicker" class="flatpickr flatpickr-input form-control" autofocus>',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes',
                        cancelButtonText: 'No',
                        didOpen: function () {
                            debugger
                            $('#empdeptdeldatetimepicker').flatpickr({
                                enableTime: true,
                                dateFormat: "m-d-Y G:i K",
                                defaultDate: date,
                                maxDate: date,
                            });
                        }
                    }).then((result) => {
                        if (result.isConfirmed) {
                            debugger
                            var time = $("#empdeptdeldatetimepicker").val();
                            var date = flatpickr.parseDate(time, "m-d-Y G:i K");
                            var month = date.getMonth() + 1;
                            time = date.getFullYear() + "-" + month + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
                            $('#eemodal').modal('hide');
                            var eenametext = document.getElementById("eenametext").value;
                            var eephone = document.getElementById("eephone").value;
                            var deptidafter = $("#eedept").val();
                            var eesubject = document.getElementById("eesubject").value;
                            var eecityid = document.getElementById("eecity").value;
                            var deptid = deptidbefore.toString();
                            var eedeptid = deptidafter.toString();
                            var joiningtime = $("#eetime").val();
                            var date = flatpickr.parseDate(joiningtime, "m-d-Y G:i K");
                            var joiningmonth = date.getMonth() + 1;
                            joiningtime = date.getFullYear() + "-" + joiningmonth + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
                            var details = {
                                eename: eename,
                                eenametext: eenametext,
                                eephone: eephone,
                                eedeptid: eedeptid,
                                eesubject: eesubject,
                                eecityid: eecityid,
                                pk: pk,
                                deptid: deptid,
                                time: time,
                                joiningtime: joiningtime
                            };
                            var str = JSON.stringify(details);
                            $('#eeditmodal').modal('hide');
                            $.ajax({
                                type: "POST",
                                url: "DTusingClass.aspx/Eedit",
                                contentType: "application/json; charset=utf-8",
                                data: str,
                                success: function () {
                                    debugger
                                    reset();
                                    table();
                                    Swal.fire('Employee has been updated!', ' ', 'success')
                                }
                            });
                        }
                    })
                }
            }

            function deletebtn(emp_id) {
                debugger
                var date = new Date();
                Swal.fire({
                    title: 'Are you sure you want to make the employee inactive?',
                    icon: 'warning',
                    html: '<input style="display:none" id="empdeldatetimepicker" class="flatpickr flatpickr-input form-control" autofocus>',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes',
                    cancelButtonText: 'No',
                    didOpen: function () {
                        debugger
                        $('#empdeldatetimepicker').flatpickr({
                            enableTime: true,
                            dateFormat: "m-d-Y G:i K",
                            defaultDate: date,
                            maxDate: date,
                        });
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        debugger
                        var time = $("#empdeldatetimepicker").val();
                        var date = flatpickr.parseDate(time, "m-d-Y G:i K");
                        var month = date.getMonth() + 1;
                        time = date.getFullYear() + "-" + month + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
                        var details = {
                            emp_id: emp_id,
                            time: time
                        };
                        var str = JSON.stringify(details);
                        $.ajax({
                            type: "POST",
                            url: "DTusingClass.aspx/Edelete",
                            contentType: "application/json; charset=utf-8",
                            data: str,
                            success: function () {
                                debugger
                                reset();
                                table();
                            }
                        });
                        Swal.fire('Employee is inactive now!', ' ', 'success')
                    }
                })
            }

            function undoemp(emp_id) {
                debugger
                Swal.fire({
                    title: 'Are you sure you want to make the employee active?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes',
                    cancelButtonText: 'No',
                }).then((result) => {
                    if (result.isConfirmed) {
                        var details = {
                            emp_id: emp_id
                        };
                        var str = JSON.stringify(details);
                        $.ajax({
                            type: "POST",
                            url: "DTusingClass.aspx/Undo",
                            contentType: "application/json; charset=utf-8",
                            data: str,
                            success: function () {
                                debugger
                                table();
                            }
                        });
                        Swal.fire('Employee is active now!', ' ', 'success')
                    }
                })
            }

            function adddept() {
                debugger
                $('#dcreatemodal').modal('show');
            }

            function dcvalidation() {
                debugger
                var dcname = document.getElementById("dcname").value;
                if (dcname == null || dcname == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Name can\'t be blank',
                    })
                    return false;
                } else {
                    Swal.fire({
                        title: 'Do you want to create a department?',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes',
                        cancelButtonText: 'No',
                    }).then((result) => {
                        if (result.isConfirmed) {
                            debugger
                            var dcname = document.getElementById("dcname").value;
                            var details = {
                                dcname: dcname
                            };
                            var str = JSON.stringify(details);
                            $('#dcreatemodal').modal('hide');
                            $.ajax({
                                type: "POST",
                                url: "DTusingClass.aspx/Dcreate",
                                contentType: "application/json; charset=utf-8",
                                data: str,
                                success: function () {
                                    debugger
                                    table();
                                    edeptdropdown();
                                    Swal.fire('Department has been created!', ' ', 'success')
                                }
                            });
                        }
                    })
                }
            }

            function deletedept() {
                debugger
                $("#ddname").css({
                    "border-color": "red",
                    "border-width": "2.2px"
                });
                $('#ddeletemodal').modal('show');
                edeptdropdown();
            }

            function ddelete() {
                var ddname = $("#ddname").val();
                if (ddname == null || ddname == "Choose one") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Department Name can\'t be blank',
                    })
                    return false;
                } else {
                    Swal.fire({
                        title: 'Are you sure you want to make the department inactive?',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes',
                        cancelButtonText: 'No',
                    }).then((result) => {
                        if (result.isConfirmed) {
                            debugger
                            $('#ddmodal').modal('hide');
                            var ddname = document.getElementById("ddname").value;
                            var details = {
                                ddname: ddname
                            };
                            var str = JSON.stringify(details);
                            $('#ddeletemodal').modal('hide');
                            $.ajax({
                                type: "POST",
                                url: "DTusingClass.aspx/Ddelete",
                                contentType: "application/json; charset=utf-8",
                                data: str,
                                success: function (data) {
                                    debugger
                                    Swal.fire('Department is inactive now!', ' ', 'success')
                                    reset();
                                    table();
                                }
                            });
                        }
                    })
                }
            }

            function undodept(dept_id) {
                debugger
                var details = {
                    dept_id: dept_id
                };
                var str = JSON.stringify(details);
                Swal.fire({
                    title: 'Are you sure you want to make the department active?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes',
                    cancelButtonText: 'No',
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            type: "POST",
                            url: "DTusingClass.aspx/UndoDept",
                            contentType: "application/json; charset=utf-8",
                            data: str,
                            success: function () {
                                debugger
                                table();
                            }
                        });
                        Swal.fire('Department is active now!', ' ', 'success')
                    }
                })
            }

            function addcity() {
                debugger
                $('#ccreatemodal').modal('show');
            }

            function ccvalidation() {
                var ccname = document.getElementById("ccname").value;
                if (ccname == null || ccname == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Name can\'t be blank',
                    })
                    return false;
                } else {
                    Swal.fire({
                        title: 'Do you want to create a city?',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes',
                        cancelButtonText: 'No',
                    }).then((result) => {
                        if (result.isConfirmed) {
                            table();
                            $('#ccmodal').modal('hide');
                            var ccname = document.getElementById("ccname").value;
                            var details = {
                                ccname: ccname
                            };
                            var str = JSON.stringify(details);
                            $('#ccreatemodal').modal('hide');
                            $.ajax({
                                type: "POST",
                                url: "DTusingClass.aspx/Ccreate",
                                contentType: "application/json; charset=utf-8",
                                data: str,
                                success: function (data) {
                                    ecitydropdown();
                                    table();
                                    Swal.fire('City has been created!', ' ', 'success')
                                }
                            });
                        }
                    })
                }
            }

            function deletecity() {
                debugger
                $("#cdname").css({
                    "border-color": "red",
                    "border-width": "2.2px"
                });
                $('#cdeletemodal').modal('show');
                ecitydropdown();
            }

            function cdelete() {
                debugger
                var cdname = $("#cdname").val();
                if (cdname == null || cdname == "Choose one") {
                    Swal.fire({
                        icon: 'error',
                        title: 'City Name can\'t be blank',
                    })
                    return false;
                } else {
                    $('#cdmodal').modal('hide');
                    Swal.fire({
                        title: 'Are you sure you want to make the city inactive?',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes',
                        cancelButtonText: 'No',
                    }).then((result) => {
                        if (result.isConfirmed) {
                            var cdname = document.getElementById("cdname").value;
                            var details = {
                                cdname: cdname
                            };
                            var str = JSON.stringify(details);
                            $('#cdeletemodal').modal('hide');
                            $.ajax({
                                type: "POST",
                                url: "DTusingClass.aspx/Cdelete",
                                contentType: "application/json; charset=utf-8",
                                data: str,
                                success: function () {
                                    Swal.fire('City is inactive now!', ' ', 'success')
                                    reset();
                                    table();
                                }
                            });
                        }
                    })
                }
            }

            function undocity(city_id) {
                debugger
                var details = {
                    city_id: city_id
                };
                var str = JSON.stringify(details);
                Swal.fire({
                    title: 'Are you sure you want to make the city active?',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes',
                    cancelButtonText: 'No',
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            type: "POST",
                            url: "DTusingClass.aspx/UndoCity",
                            contentType: "application/json; charset=utf-8",
                            data: str,
                            success: function () {
                                debugger
                                table();
                            }
                        });
                        Swal.fire('City is active now!', ' ', 'success')
                    }
                })
            }
		</script>
	</body>

	</html>