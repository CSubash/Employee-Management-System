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
		
		.employee-inactive-tooltip {
			height: 25px;
			width: 25px;
			background-color: grey;
			border-radius: 50%;
			display: inline-block;
		}
		
		.department-inactive-tooltip {
			height: 25px;
			width: 25px;
			background-color: #f4e285;
			border-radius: 50%;
			display: inline-block;
		}
		
		.city-inactive-tooltip {
			height: 25px;
			width: 25px;
			background-color: #F77F00;
			border-radius: 50%;
			display: inline-block;
		}
		
		.employee-department-inactive-tooltip {
			height: 25px;
			width: 25px;
			background-color: #606C38;
			border-radius: 50%;
			display: inline-block;
		}
		
		.employee-city-inactive-tooltip {
			height: 25px;
			width: 25px;
			background-color: #80ffdb;
			border-radius: 50%;
			display: inline-block;
		}
		
		.department-city-inactive-tooltip {
			height: 25px;
			width: 25px;
			background-color: #8338ec;
			border-radius: 50%;
			display: inline-block;
		}
		
		.employee-department-city-inactive-tooltip {
			height: 25px;
			width: 25px;
			background-color: #ff5d8f;
			border-radius: 50%;
			display: inline-block;
		}
		
		#employeeCreateDepartment, #employeeEditDepartment {
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
		<form id="employeeForm" runat="server">
			<div class="container-fluid">
				<div class="modal fade" id="employeeCreateModal" data-backdrop="static">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">Enter Employee Details</h4>
								<button type="button" class="close" data-dismiss="modal" onclick="Reset()">&times;</button>
							</div>
							<div class="modal-body m-2">
								<div class="row mb-4">
									<label class="col-form-label">Name:</label>
									<div class="col">
										<input type="text" id="employeeCreateName" class="form-control" runat="server" required> </div>
									<label class="col-form-label">Phone:</label>
									<div class="col">
										<input type="number" id="employeeCreatePhone" class="form-control" runat="server" required> </div>
								</div>
								<div class="row mb-4">
									<label class="col-form-label">Dept:</label>
									<div class="col pl-4">
										<select id="employeeCreateDepartment" class="form-control" multiple="true" runat="server" required></select>
									</div>
									<label class="col-form-label">Subject:</label>
									<div class="col">
										<input type="text" id="employeeCreateSubject" class="form-control" runat="server" required> </div>
								</div>
								<div class="row mb-4">
									<label class="col-form-label">City:</label>
									<div class="col-5 ml-2">
										<select id="employeeCreateCity" class="form-control" runat="server" required></select>
									</div>
									<label class="col-form-label">Time:</label>
									<div class="col-5">
										<input id="employeeJoiningTime" class="flatpickr flatpickr-input form-control" autofocus runat="server" required> </div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-success" onclick="EmployeeCreateValidation()" runat="server">Add</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="employeeEditModal" data-backdrop="static">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">Edit Employee Details</h4>
								<button type="button" class="close" data-dismiss="modal" onclick="Reset()">&times;</button>
							</div>
							<div class="modal-body m-2">
								<div class="row mb-4">
									<div class="col-sm-6">
										<label>Name</label>
										<input type="text" id="employeeEditNameText" class="form-control" runat="server" required> </div>
									<div class="col-sm-6">
										<label>Phone</label>
										<input type="number" id="employeeEditPhone" class="form-control" runat="server" required> </div>
								</div>
								<div class="row mb-4">
									<div class="col-sm-6">
										<label>Dept</label>
										<select id="employeeEditDepartment" class="form-control" multiple="true" data-width="100%" runat="server" required></select>
									</div>
									<div class="col-sm-6">
										<label>Subject</label>
										<input type="text" id="employeeEditSubject" class="form-control" runat="server" required> </div>
								</div>
								<div class="row">
									<div class="col-sm-6">
										<label>City</label>
										<select id="employeeEditCity" class="form-control" runat="server"></select>
									</div>
									<div class="col-sm-6">
										<label>Time</label>
										<input id="employeeEditTime" class="flatpickr flatpickr-input form-control" autofocus runat="server" required> </div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="Reset()" runat="server">Close</button>
								<button type="button" class="btn btn-warning" onclick="EmployeeEdit()" runat="server">Update</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="employeeDeleteModal" data-backdrop="static">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">Delete Employee</h4>
								<button type="button" class="close" data-dismiss="modal" onclick="Reset()">&times;</button>
							</div>
							<div class="modal-body m-2">
								<div class="row mb-4">
									<label class="col-form-label">Name:</label>
									<div class="col">
										<input type="text" id="employeeDeleteNameText" class="form-control" runat="server" disabled> </div>
									<label class="col-form-label">Phone:</label>
									<div class="col">
										<input type="number" id="employeeDeletePhone" class="form-control" runat="server" disabled> </div>
								</div>
								<div class="row mb-4">
									<label class="col-form-label">Dept:</label>
									<div class="col">
										<input type="text" id="employeeDeleteDepartment" class="form-control" runat="server" disabled> </div>
									<label class="col-form-label">Subject:</label>
									<div class="col">
										<input type="text" id="employeeDeleteSubject" class="form-control" runat="server" disabled> </div>
								</div>
								<div class="row mb-4">
									<label class="col-form-label">City:</label>
									<div class="col">
										<input type="text" id="employeeDeleteCity" class="form-control" runat="server" disabled> </div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" onclick="EmployeeDelete()" runat="server">Delete</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="departmentCreateModal" data-backdrop="static">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">Enter Department Details</h4>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
							<div class="modal-body m-2">
								<div class="row mb-4">
									<label class="col-form-label">Name:</label>
									<div class="col">
										<input type="text" id="departmentCreateName" class="form-control" runat="server" required> </div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-success" onclick="DepartmentCreateValidation()" runat="server">Add</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="departmentDeleteModal" data-backdrop="static">
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
										<select id="departmentDeleteName" class="form-control" onchange="DepartmentDeleteChangeColor()" runat="server"></select>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" onclick="DepartmentDelete()" runat="server">Delete</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="cityCreateModal" data-backdrop="static">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">Enter City Details</h4>
								<button type="button" class="close" data-dismiss="modal">&times;</button>
							</div>
							<div class="modal-body m-2">
								<div class="row mb-4">
									<label class="col-form-label">City Name:</label>
									<div class="col">
										<input type="text" id="cityCreateName" class="form-control" runat="server" required> </div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-success" onclick="CityCreateValidation()" runat="server">Add</button>
							</div>
						</div>
					</div>
				</div>
				<div class="modal fade" id="cityDeleteModal" data-backdrop="static">
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
										<select id="cityDeleteName" class="form-control" onchange="CityDeleteChangeColor()" runat="server"></select>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger" onclick="CityDelete()" runat="server">Delete</button>
							</div>
						</div>
					</div>
				</div>
				<div class="card tab-content">
					<div class="card-header text-left p-1" id="cardHeader">
						<button type="button" onclick="AddEmployee()" class="btn btn-default btn-success"><span class="fas fa-plus"></span> Employee</button>
						<button type="button" onclick="AddDepartment()" class="btn btn-default btn-success"><span class="fas fa-plus"></span> Department</button>
						<button type="button" onclick="AddCity()" class="btn btn-default btn-success"><span class="fas fa-plus"></span> City</button>
						<button type="button" onclick="DeleteDepartment()" class="btn btn-default btn-danger"><span class="fas fa-trash"></span> Department</button>
						<button type="button" onclick="DeleteCity()" class="btn btn-default btn-danger"><span class="fas fa-trash"></span> City</button>
						<button type="button" onclick="Table()" class="btn btn-default btn-info"><span class="fas fa-sync-alt"></span> Refresh</button>
						<div id="infoButton" class="btn btn-secondary" data-toggle="tooltip" style="float: right;" data-html="true"><i class="fas fa-info"></i> Legend</div>
					</div>
					<div class="card-body container-fluid">
						<table id="employeeTable" class="table table-bordered">
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

            var DEPARTMENT_ID_BEFORE = "";
            var DEPARTMENT_BUTTON_REMOVE = [];
            var EMPLOYEE_ID = "";

            $(document).ready(function () {
                Reset();
                $('#employeeCreateDepartment').select2();
                $('#employeeEditDepartment').select2();
                $("#departmentDeleteName").css({
                    "border-color": "red",
                    "border-width": "2.2px"
                });
                $("#cityDeleteName").css({
                    "border-color": "red",
                    "border-width": "2.2px"
                });
                $('[data-toggle="undoDepartmentName"]').tooltip();
                $("#infoButton").tooltip({
                    title: '<div class="row"><div class="col-sm-1 employee-inactive-tooltip"></div><pre style="color:red;"> - Employee is inactive</pre> <br> <br> </div><div class="row"><div class= "col-sm-1 department-inactive-tooltip"></div><pre style="color:red;"> - Department is inactive</pre> <br> <br> </div><div class="row"><div class="col-sm-1 city-inactive-tooltip"></div><pre style="color:red;"> - City is inactive</pre> <br> <br> </div><div class="row"><div class= "col-sm-1 employee-department-inactive-tooltip"></div><pre style="color:red;"> - Both Employee and Department are inactive</pre> <br> <br> </div><div class="row"><div class= "col-sm-1 employee-city-inactive-tooltip"></div><pre style="color:red;"> - Both Employee and City are inactive</pre> <br> <br> </div><div class="row"><div class="col-sm-1 department-city-inactive-tooltip"></div><pre style="color:red;"> - Both Department and City are inactive</pre> <br> <br> </div><div class="row"><div class="col-sm-1 employee-department-city-inactive-tooltip"></div><pre style="color:red;"> - Employee, Department and City are inactive</pre></div></div>',
                    html: true,
                });
                Table();
            });

            function Reset() {
                document.getElementById("employeeForm").reset();
            }

            function DepartmentDeleteChangeColor() {
                $("#departmentDeleteName").css({
                    "border-color": "green",
                    "border-width": "2.2px"
                });
            }

            function CityDeleteChangeColor() {
                $("#cityDeleteName").css({
                    "border-color": "green",
                    "border-width": "2.2px"
                });
            }

            function Table() {
                $.ajax({
                    type: "POST",
                    url: "DTusingClass.aspx/Table",
                    contentType: "application/json; charset=utf-8",
                    beforeSend: function () {
                        $('#tr').html("LOADING....");
                    },
                    success: function (result) {
                        var json = JSON.parse(result.d);
                        if (!$.fn.DataTable.isDataTable('#employeeTable')) {
                            $("#employeeTable").DataTable({
                                "responsive": true,
                                "bScrollCollapse": true,
                                "autoWidth": false,
                                "order": [0, "asc"],
                                "data": json,
                                dom: '<"row"<"col-xl-2 col-lg-12 col-md-12 col-sm-12"P><"col-xl-10 col-lg-12 col-md-12 col-sm-12"frtipl>>',
                                "columns": [{
                                    "data": "EmployeeName",
                                    title: "Employee Name"
                                }, {
                                    "data": "Phone",
                                    title: "Phone"
                                }, {
                                    "data": "Subject",
                                    title: "Subject"
                                }, {
                                    "data": "IsActive",
                                    title: "Is Active"
                                }, {
                                    "data": "DepartmentName",
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
                                    "data": "CityName",
                                    title: "City"
                                }, {
                                    "data": "EmployeeJoiningTime",
                                    title: "Joining Time",
                                    "type": "date"
                                }, {
                                    "data": "Buttons",
                                    title: "Buttons"
                                }, {
                                    "data": "DepartmentIsDeleted",
                                    title: "Dept_Is_Deleted"
                                }, {
                                    "data": "CityIsDeleted",
                                    title: "City_Is_Deleted"
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
                                        $("#employeeTable").DataTable().button(2).disable();
                                    } else {
                                        $("#employeeTable").DataTable().button(2).enable();
                                    }
                                    $.each($("#employeeTable tr"), function () {
                                        let rowCount = $("#employeeTable tr th").length;
                                        let text1 = $(this).find('td').eq(8).text();
                                        let text = $(this).find('td').eq(7).text().split(" ").join("");
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
                            $("#employeeTable").DataTable().buttons().container().appendTo($('#cardHeader'));
                            $("#employeeTable_length").insertBefore("#employeeTable");
                        } else {
                            $("#employeeTable").DataTable().clear();
                            $('#employeeTable tbody:first').before('<tr class="loading-tr"></tr>');
                            $('.loading-tr').html("LOADING....");
                            $("#employeeTable").DataTable().rows.add(json).draw();
                            $(".loading-tr").show();
                        }
                    },
                    complete: function () {
                        $("#tr").toggle();
                        setTimeout(function () {
                            $(".loading-tr").remove();
                        }, 2000);
                    }
                });
            }

            function EmployeeDepartmentDropdown(dept) {
                $.ajax({
                    type: "POST",
                    url: "DTusingClass.aspx/DepartmentDropdown",
                    contentType: "application/json; charset=utf-8",
                    success: function (result) {
                        var data = JSON.parse(result.d);
                        if (dept == null) {
                            var departmentOption = '<option selected value="0" disabled>Choose one</option>';
                            for (let i=0; i<data.length; i=i+3) {
                                departmentOption += '<option value=' + data[i] + '>' + data[i+1] + '</option>';
                                $("#employeeCreateDepartment").html(departmentOption);
                                $("#employeeEditDepartment").html(departmentOption);
                                $("#departmentDeleteName").html(departmentOption);
                                $('#employeeCreateDepartment option').attr('selected', false);
                            }
                        } else {
                            var departmentSelectedOption = '';
                            var selected = "";
                            var deptlength = dept.split(",").length;
                            for (let i=0; i<data.length; i=i+3) {
                                for (let j=0; j<deptlength; j++) {
                                    if (data[i+1] == dept.split(',')[j]) {
                                        if (data[i + 2] == 1) {
                                            departmentSelectedOption += '<option selected value=' + data[i] + ' disabled>' + data[i+1] + '</option>';
                                            DEPARTMENT_BUTTON_REMOVE.push(data[i+1]);
                                        } else {
                                            departmentSelectedOption += '<option selected value=' + data[i] + '>' + data[i+1] + '</option>';
                                            DEPARTMENT_BUTTON_REMOVE.pop(data[i+1]);
                                        }
                                        j = deptlength;
                                        selected = 1;
                                    }
                                }
                                if (selected == "0") {
                                    if (data[i+2] == 1) {
                                        departmentSelectedOption += '<option value=' + data[i] + ' disabled>' + data[i+1] + '</option>';
                                    } else {
                                        departmentSelectedOption += '<option value=' + data[i] + '>' + data[i+1] + '</option>';
                                    }
                                }
                                $("#employeeEditDepartment").html(departmentSelectedOption);
                                selected = 0;
                            }
                        }
                        DEPARTMENT_ID_BEFORE = $("#employeeEditDepartment").val();
                    }
                });
                setTimeout(function () {
                    for (let i = 0; i < DEPARTMENT_BUTTON_REMOVE.length; i++) {
                        $('.select2-selection__choice[title="' + DEPARTMENT_BUTTON_REMOVE[i] + '"] > .select2-selection__choice__remove').remove()
                    }
                }, 50);
            }

            function EmployeeCityDropdown(city) {
                $.ajax({
                    type: "POST",
                    url: "DTusingClass.aspx/CityDropdown",
                    contentType: "application/json; charset=utf-8",
                    success: function (result) {
                        var data = JSON.parse(result.d);
                        if (city == null) {
                            var cityOption = '<option selected value="" disabled>Choose one</option>';
                            for (let i=0; i<data.length; i=i+3) {
                                cityOption += '<option value=' + data[i] + '>' + data[i+1] + '</option>';
                                $("#employeeCreateCity").html(cityOption);
                                $("#employeeEditCity").html(cityOption);
                                $("#cityDeleteName").html(cityOption);
                            }
                            $('#cityDeleteName').selectize({});
                        } else {
                            var citySelectedOption = '<option selected value="0" disabled>Choose one</option>';
                            for (let i=0; i<data.length; i=i+3) {
                                if (data[i+1] == city) {
                                    if (data[i+2] == 1) {
                                        citySelectedOption += '<option selected value=' + data[i] + ' disabled>' + data[i+1] + '</option>';
                                    } else {
                                        citySelectedOption += '<option selected value=' + data[i] + '>' + data[i + 1] + '</option>';
                                    }
                                } else {
                                    if (data[i+2] == 1) {
                                        citySelectedOption += '<option value=' + data[i] + ' disabled>' + data[i+1] + '</option>';
                                    } else {
                                        citySelectedOption += '<option value=' + data[i] + '>' + data[i+1] + '</option>';
                                    }
                                }
                                $("#employeeCreateCity").html(citySelectedOption);
                                $("#employeeEditCity").html(citySelectedOption);
                            }
                        }
                    }
                });
            }

            function AddEmployee() {
                $('#employeeCreateModal').modal('show');
                EmployeeDepartmentDropdown();
                EmployeeCityDropdown();
                var date = new Date();
                $('#employeeJoiningTime').flatpickr({
                    enableTime: true,
                    dateFormat: "m-d-Y G:i K",
                    defaultDate: date,
                    maxDate: date,
                });
            }

            function EmployeeCreateValidation() {
                var employeeCreateName = document.getElementById("employeeCreateName").value;
                var employeeCreatePhone = document.getElementById("employeeCreatePhone").value;
                var employeeCreateDepartment = $("#employeeCreateDepartment").find('option:selected').text();
                var employeeCreateSubject = document.getElementById("employeeCreateSubject").value;
                var employeeCreateCity = $("#employeeCreateCity").find('option:selected').text();
                if (employeeCreateName == null || employeeCreateName == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Name can\'t be blank',
                    })
                    return false;
                } else if (employeeCreatePhone.length != 10) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Phone number must be 10 characters long',
                    })
                    return false;
                } else if (employeeCreateDepartment == null || employeeCreateDepartment == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Department can\'t be blank',
                    })
                    return false;
                } else if (employeeCreateSubject == null || employeeCreateSubject == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Subject can\'t be blank',
                    })
                    return false;
                } else if (employeeCreateCity == null || employeeCreateCity == "Choose one") {
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
                            var employeeJoiningTime = $("#employeeJoiningTime").val();
                            var employeeCreateName = document.getElementById("employeeCreateName").value;
                            var employeeCreatePhone = document.getElementById("employeeCreatePhone").value;
                            var employeeCreateDepartmentID = $("#employeeCreateDepartment").val();
                            var employeeCreateDepartmentIDCount = $("#employeeCreateDepartment :selected").length;
                            var employeeCreateSubject = document.getElementById("employeeCreateSubject").value;
                            var employeeCreateCityID = document.getElementById("employeeCreateCity").value;
                            var details = {
                                employeeCreateName: employeeCreateName,
                                employeeCreatePhone: employeeCreatePhone,
                                employeeCreateDepartmentID: employeeCreateDepartmentID,
                                employeeCreateDepartmentIDCount: employeeCreateDepartmentIDCount,
                                employeeCreateSubject: employeeCreateSubject,
                                employeeCreateCityID: employeeCreateCityID,
                                employeeJoiningTime: employeeJoiningTime
                            };
                            var str = JSON.stringify(details);
                            $('#employeeCreateModal').modal('hide');
                            $.ajax({
                                type: "POST",
                                url: "DTusingClass.aspx/EmployeeCreate",
                                contentType: "application/json; charset=utf-8",
                                data: str,
                                success: function () {
                                    Reset();
                                    Table();
                                    Swal.fire('Employee has been created!', ' ', 'success')
                                }
                            });
                        }
                    })
                }
            }

            function EditButton(employeeID) {
                var details = {
                    employeeID: employeeID
                };
                var str = JSON.stringify(details);
                $.ajax({
                    type: "POST",
                    url: "DTusingClass.aspx/EmployeeEditDetails",
                    contentType: "application/json; charset=utf-8",
                    data: str,
                    success: function (result) {
                        var data = JSON.parse(result.d);
                        EMPLOYEE_ID = employeeID;
                        EmployeeDepartmentDropdown(data[3]);
                        EmployeeCityDropdown(data[4]);
                        document.getElementById('employeeEditNameText').value = data[0];
                        document.getElementById("employeeEditPhone").value = data[1];
                        $('#employeeEditDepartment option').attr('selected', false);
                        $('#employeeEditDepartment option:contains("' + data[3] + '")').attr('selected', true);
                        document.getElementById("employeeEditSubject").value = data[2];
                        $('#employeeEditCity option').attr('selected', false);
                        $('#employeeEditCity option:contains("' + data[4] + '")').attr('selected', true);
                        var date = new Date();
                        $('#employeeEditTime').flatpickr({
                            enableTime: true,
                            dateFormat: "m-d-Y G:i K",
                            defaultDate: data[5],
                            maxDate: date,
                        });
                    }
                });
            }

            function EmployeeEdit() {
                $('#employeeEditModal').modal('hide');
                var employeeEditNameText = document.getElementById("employeeEditNameText").value;
                var employeeEditPhone = document.getElementById("employeeEditPhone").value;
                var employeeEditDepartment = $("#employeeEditDepartment").find('option:selected').text();
                var employeeEditSubject = document.getElementById("employeeEditSubject").value;
                var employeeEditCity = $("#employeeEditCity").find('option:selected').text();
                if (employeeEditNameText == null || employeeEditNameText == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Name can\'t be blank',
                    })
                    return false;
                } else if (employeeEditPhone.length != 10) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Phone number must be 10 characters long',
                    })
                    return false;
                } else if (employeeEditDepartment == null || employeeEditDepartment == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Department can\'t be blank',
                    })
                    return false;
                } else if (employeeEditSubject == null || employeeEditSubject == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Subject can\'t be blank',
                    })
                    return false;
                } else if (employeeEditCity == null || employeeEditCity == "Choose one") {
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
                        html: '<input style="display:none" id="employeeDepartmentDeleteDateTime" class="flatpickr flatpickr-input form-control" autofocus>',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Yes',
                        cancelButtonText: 'No',
                        didOpen: function () {
                            $('#employeeDepartmentDeleteDateTime').flatpickr({
                                enableTime: true,
                                dateFormat: "m-d-Y G:i K",
                                defaultDate: date,
                                maxDate: date,
                            });
                        }
                    }).then((result) => {
                        if (result.isConfirmed) {
                            var time = $("#employeeDepartmentDeleteDateTime").val();
                            var date = flatpickr.parseDate(time, "m-d-Y G:i K");
                            var month = date.getMonth() + 1;
                            time = date.getFullYear() + "-" + month + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
                            var employeeEditNameText = document.getElementById("employeeEditNameText").value;
                            var employeeEditPhone = document.getElementById("employeeEditPhone").value;
                            var departmentIDAfter = $("#employeeEditDepartment").val();
                            var employeeEditSubject = document.getElementById("employeeEditSubject").value;
                            var employeeEditCityID = document.getElementById("employeeEditCity").value;
                            var departmentID = DEPARTMENT_ID_BEFORE.toString();
                            var employeeEditDepartmentID = departmentIDAfter.toString();
                            var joiningTime = $("#employeeEditTime").val();
                            var date = flatpickr.parseDate(joiningTime, "m-d-Y G:i K");
                            var joiningMonth = date.getMonth() + 1;
                            joiningTime = date.getFullYear() + "-" + joiningMonth + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
                            var details = {
                                employeeEditName: EMPLOYEE_ID,
                                employeeEditNameText: employeeEditNameText,
                                employeeEditPhone: employeeEditPhone,
                                employeeEditDepartmentID: employeeEditDepartmentID,
                                employeeEditSubject: employeeEditSubject,
                                employeeEditCityID: employeeEditCityID,
                                departmentID: departmentID,
                                time: time,
                                joiningTime: joiningTime
                            };
                            var str = JSON.stringify(details);
                            $('#employeeEditModal').modal('hide');
                            $.ajax({
                                type: "POST",
                                url: "DTusingClass.aspx/EmployeeEdit",
                                contentType: "application/json; charset=utf-8",
                                data: str,
                                success: function () {
                                    Reset();
                                    Table();
                                    Swal.fire('Employee has been updated!', ' ', 'success')
                                }
                            });
                        }
                    })
                }
            }

            function DeleteButton(employeeID) {
                var date = new Date();
                Swal.fire({
                    title: 'Are you sure you want to make the employee inactive?',
                    icon: 'warning',
                    html: '<input style="display:none" id="employeeDeleteDateTime" class="flatpickr flatpickr-input form-control" autofocus>',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes',
                    cancelButtonText: 'No',
                    didOpen: function () {
                        $('#employeeDeleteDateTime').flatpickr({
                            enableTime: true,
                            dateFormat: "m-d-Y G:i K",
                            defaultDate: date,
                            maxDate: date,
                        });
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        var time = $("#employeeDeleteDateTime").val();
                        var date = flatpickr.parseDate(time, "m-d-Y G:i K");
                        var month = date.getMonth() + 1;
                        time = date.getFullYear() + "-" + month + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
                        var details = {
                            employeeID: employeeID,
                            time: time
                        };
                        var str = JSON.stringify(details);
                        $.ajax({
                            type: "POST",
                            url: "DTusingClass.aspx/EmployeeDelete",
                            contentType: "application/json; charset=utf-8",
                            data: str,
                            success: function () {
                                Reset();
                                Table();
                            }
                        });
                        Swal.fire('Employee is inactive now!', ' ', 'success')
                    }
                })
            }

            function UndoEmployee(employeeID) {
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
                            employeeID: employeeID
                        };
                        var str = JSON.stringify(details);
                        $.ajax({
                            type: "POST",
                            url: "DTusingClass.aspx/UndoEmployee",
                            contentType: "application/json; charset=utf-8",
                            data: str,
                            success: function () {
                                Table();
                            }
                        });
                        Swal.fire('Employee is active now!', ' ', 'success')
                    }
                })
            }

            function AddDepartment() {
                $('#departmentCreateModal').modal('show');
            }

            function DepartmentCreateValidation() {
                var departmentCreateName = document.getElementById("departmentCreateName").value;
                if (departmentCreateName == null || departmentCreateName == "") {
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
                            var departmentCreateName = document.getElementById("departmentCreateName").value;
                            var details = {
                                departmentCreateName: departmentCreateName
                            };
                            var str = JSON.stringify(details);
                            $('#departmentCreateModal').modal('hide');
                            $.ajax({
                                type: "POST",
                                url: "DTusingClass.aspx/DepartmentCreate",
                                contentType: "application/json; charset=utf-8",
                                data: str,
                                success: function () {
                                    Table();
                                    EmployeeDepartmentDropdown();
                                    Swal.fire('Department has been created!', ' ', 'success')
                                }
                            });
                        }
                    })
                }
            }

            function DeleteDepartment() {
                $("#departmentDeleteName").css({
                    "border-color": "red",
                    "border-width": "2.2px"
                });
                $('#departmentDeleteModal').modal('show');
                EmployeeDepartmentDropdown();
            }

            function DepartmentDelete() {
                var departmentDeleteName = $("#departmentDeleteName").val();
                if (departmentDeleteName == null || departmentDeleteName == "Choose one") {
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
                            $('#ddmodal').modal('hide');
                            var departmentDeleteName = document.getElementById("departmentDeleteName").value;
                            var details = {
                                departmentDeleteName: departmentDeleteName
                            };
                            var str = JSON.stringify(details);
                            $('#departmentDeleteModal').modal('hide');
                            $.ajax({
                                type: "POST",
                                url: "DTusingClass.aspx/DepartmentDelete",
                                contentType: "application/json; charset=utf-8",
                                data: str,
                                success: function (data) {
                                    Swal.fire('Department is inactive now!', ' ', 'success')
                                    Reset();
                                    Table();
                                }
                            });
                        }
                    })
                }
            }

            function UndoDepartment(departmentID) {
                var details = {
                    departmentID: departmentID
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
                            url: "DTusingClass.aspx/UndoDepartment",
                            contentType: "application/json; charset=utf-8",
                            data: str,
                            success: function () {
                                Table();
                            }
                        });
                        Swal.fire('Department is active now!', ' ', 'success')
                    }
                })
            }

            function AddCity() {
                $('#cityCreateModal').modal('show');
            }

            function CityCreateValidation() {
                var cityCreateName = document.getElementById("cityCreateName").value;
                if (cityCreateName == null || cityCreateName == "") {
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
                            Table();
                            $('#ccmodal').modal('hide');
                            var cityCreateName = document.getElementById("cityCreateName").value;
                            var details = {
                                cityCreateName: cityCreateName
                            };
                            var str = JSON.stringify(details);
                            $('#cityCreateModal').modal('hide');
                            $.ajax({
                                type: "POST",
                                url: "DTusingClass.aspx/CityCreate",
                                contentType: "application/json; charset=utf-8",
                                data: str,
                                success: function (data) {
                                    EmployeeCityDropdown();
                                    Table();
                                    Swal.fire('City has been created!', ' ', 'success')
                                }
                            });
                        }
                    })
                }
            }

            function DeleteCity() {
                $("#cityDeleteName").css({
                    "border-color": "red",
                    "border-width": "2.2px"
                });
                $('#cityDeleteModal').modal('show');
                EmployeeCityDropdown();
            }

            function CityDelete() {
                var cityDeleteName = $("#cityDeleteName").val();
                if (cityDeleteName == null || cityDeleteName == "Choose one") {
                    Swal.fire({
                        icon: 'error',
                        title: 'City Name can\'t be blank',
                    })
                    return false;
                } else {
                    $('#cityDeleteModal').modal('hide');
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
                            var cityDeleteName = document.getElementById("cityDeleteName").value;
                            var details = {
                                cityDeleteName: cityDeleteName
                            };
                            var str = JSON.stringify(details);
                            $('#cityDeleteModal').modal('hide');
                            $.ajax({
                                type: "POST",
                                url: "DTusingClass.aspx/CityDelete",
                                contentType: "application/json; charset=utf-8",
                                data: str,
                                success: function () {
                                    Swal.fire('City is inactive now!', ' ', 'success')
                                    Reset();
                                    Table();
                                }
                            });
                        }
                    })
                }
            }

            function UndoCity(cityID) {
                var details = {
                    cityID: cityID
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
                                Table();
                            }
                        });
                        Swal.fire('City is active now!', ' ', 'success')
                    }
                })
            }
        </script>
	</body>

	</html>