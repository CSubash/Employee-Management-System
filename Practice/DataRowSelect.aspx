<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DataRowSelect.aspx.cs" Inherits="Practice.DataRowSelect" %>

<!DOCTYPE html>

<html>
<head runat="server">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <title>Data Row</title>
</head>
<body>
    <form id="form1" runat="server">
        <center>
            <div class="container-fluid p-2">
                <button type="button" class="btn btn-success" onclick="employeetable()" runat="server">Employee</button>
                <button type="button" class="btn btn-success" onclick="depttable()" runat="server">Department</button>
                <button type="button" class="btn btn-success" onclick="citytable()" runat="server">City</button>
                <div id="div1" class="container p-2" runat="server">
                </div>
            </div>
        </center>
    </form>
    <script>

        $(document).ready(function () {
            debugger
        });

        function employeetable() {
            debugger
            var str = JSON.stringify({ emp: 1, dept: 0, city: 0 });
            $.ajax({
                type: "POST",
                url: "DataRowSelect.aspx/Table",
                contentType: "application/json; charset=utf-8",
                data: str,
                success: function (data) {
                    debugger
                    $("#div1").html(data.d);
                }
            });
        }

        function depttable() {
            debugger
            var str = JSON.stringify({ emp: 0, dept: 1, city: 0});
            $.ajax({
                type: "POST",
                url: "DataRowSelect.aspx/Table",
                contentType: "application/json; charset=utf-8",
                data: str,
                success: function (data) {
                    debugger
                    $("#div1").html(data.d);
                }
            });
        }

        function citytable() {
            debugger
            var str = JSON.stringify({ emp: 0, dept: 0, city: 1 });
            $.ajax({
                type: "POST",
                url: "DataRowSelect.aspx/Table",
                contentType: "application/json; charset=utf-8",
                data: str,
                success: function (data) {
                    debugger
                    $("#div1").html(data.d);
                }
            });
        }

    </script>
</body>
    
</html>
