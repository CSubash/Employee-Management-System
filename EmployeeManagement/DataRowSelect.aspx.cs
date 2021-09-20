using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.Services;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;


namespace EmployeeManagement
{
    public partial class DataRowSelect : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string Table(dynamic emp, dynamic dept, dynamic city)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                var sqlname = "";
                var oppsqlname = "";
                var ascname = "";

                var edcid = "";
                var columnname = "";
                var oppcolumnname = "";
                var firstcolumnname = "";
                var columnid = "";
                var name = "";
                var oppname = "";
                var firstname = "";

                if (emp == 1)
                {
                    sqlname = "emp_name";
                    oppsqlname = "dept_name";
                    ascname = "emp_id";

                    edcid = "emp_id";
                    columnname = "emp_name";
                    firstcolumnname = "dept_name";
                    oppcolumnname = "city_name";
                    columnid = "dept_id";
                    name = "EMPLOYEE";
                    firstname = "DEPARTMENT";
                    oppname = "CITY";
                }
                else if (dept == 1)
                {
                    sqlname = "dept_name";
                    oppsqlname = "city_name";
                    ascname = "emp_name";

                    edcid = "dept_id";
                    columnname = "dept_name";
                    firstcolumnname = "emp_name";
                    oppcolumnname = "city_name";
                    columnid = "dept_id";
                    name = "DEPARTMENT";
                    firstname = "EMP NAME";
                    oppname = "CITY";
                }
                else if (city == 1)
                {
                    sqlname = "city_name";
                    oppsqlname = "dept_name";
                    ascname = "emp_name";

                    edcid = "city_id";
                    columnname = "city_name";
                    firstcolumnname = "emp_name";
                    oppcolumnname = "dept_name";
                    columnid = "city_id";
                    name = "CITY";
                    firstname = "EMP NAME";
                    oppname = "DEPARTMENT";
                }
                string query = "SELECT employee.emp_id,employee.emp_name,employee.phone,employee.subject,employee.is_active,empdept.dept_id, empdept.id,department.dept_name,department.dept_is_deleted,city.city_id,city.city_name,city.city_is_deleted FROM employee JOIN empdept ON employee.emp_id=empdept.emp_id JOIN city ON employee.city_id=city.city_id JOIN department ON empdept.dept_id=department.dept_id WHERE empdept.empdept_is_deleted = '0' ORDER BY " + sqlname + " ASC, " + ascname + " ASC, " + oppsqlname + " ASC;";
                con.Open();
                MySqlDataAdapter sda = new MySqlDataAdapter(query, con);
                DataSet ds = new DataSet();
                sda.Fill(ds, "results");
                StringBuilder html = new StringBuilder();
                ArrayList arlist = new ArrayList();
                var id = "";
                var previd = "";
                var tablecreate = "";
                foreach (DataRow dr in ds.Tables["results"].Rows)
                {
                    id = dr["" + edcid + ""].ToString();
                    if (previd == id)
                    {
                        tablecreate = "0";
                    }
                    else if (previd != "")
                    {
                        html.Append("</table>");
                        html.Append("<br>");
                        tablecreate = "1";
                    }
                    else if(previd == "")
                    {
                        tablecreate = "1";
                    }
                    if(tablecreate == "1")
                    {
                        html.Append("<table class='table table-bordered'>");
                        var headingcolor = "";
                        var check = dr["dept_name"].ToString();
                        if (dr["is_active"].ToString() == "n" & name == "EMPLOYEE")
                        {
                            headingcolor = "red";
                        }
                        else if (dr["is_active"].ToString() == "y" & name == "EMPLOYEE")
                        {
                            headingcolor = "white";
                        }
                        if (dr["city_is_deleted"].ToString() == "1" & name == "CITY")
                        {
                            headingcolor = "red";
                        }
                        else if (dr["city_is_deleted"].ToString() == "0" & name == "CITY")
                        {
                            headingcolor = "white";
                        }
                        if (dr["dept_is_deleted"].ToString() == "1" & name == "DEPARTMENT")
                        {
                            headingcolor = "red";
                        }
                        else if (dr["dept_is_deleted"].ToString() == "0" & name == "DEPARTMENT")
                        {
                            headingcolor = "white";
                        }
                        if (name == "EMPLOYEE")
                        {
                            html.Append("<th colspan='6' style='background-color:" + headingcolor + ";' title = 'EMPID: " + dr["emp_id"].ToString() + "&#010;PHONE:" + dr["phone"].ToString() + "&#010;SUBJECT: " + dr["subject"].ToString() + "'>" + name + " NAME - " + dr["" + columnname + ""].ToString() + " (" + dr["" + columnid + ""].ToString() + ")</th>");
                        }
                        else
                        {
                            html.Append("<th colspan='6' style='background-color:" + headingcolor + ";'>" + name + " NAME - " + dr["" + columnname + ""].ToString() + " (" + dr["" + columnid + ""].ToString() + ")</th>");
                        }
                            html.Append("<tr>");
                        html.Append("<th> " + firstname + " </th>");
                        html.Append("<th> " + oppname + " NAME </th>");
                        html.Append("</tr>");
                    }
                    html.Append("<tr>");
                    var firstcolumncolor = "";
                    var secondcolumncolor = "";
                    if (dr["dept_is_deleted"].ToString() == "1" & name == "EMPLOYEE")
                    {
                        firstcolumncolor = "red";
                    }
                    else if (dr["dept_is_deleted"].ToString() == "0" & name == "EMPLOYEE")
                    {
                        firstcolumncolor = "white";
                    }
                    if (dr["is_active"].ToString() == "n" & (name == "DEPARTMENT" || name == "CITY"))
                    {
                        firstcolumncolor = "red";
                    }
                    else if (dr["is_active"].ToString() == "y" & (name == "DEPARTMENT" || name == "CITY"))
                    {
                        firstcolumncolor = "white";
                    }


                    if (dr["city_is_deleted"].ToString() == "1" & (name == "DEPARTMENT" || name == "EMPLOYEE"))
                    {
                        secondcolumncolor = "red";
                    }
                    else if (dr["city_is_deleted"].ToString() == "0" & (name == "DEPARTMENT" || name == "EMPLOYEE"))
                    {
                        secondcolumncolor = "white";
                    }
                    if (dr["dept_is_deleted"].ToString() == "1" & name == "CITY")
                    {
                        secondcolumncolor = "red";
                    }
                    else if (dr["dept_is_deleted"].ToString() == "0" & name == "CITY")
                    {
                        secondcolumncolor = "white";
                    }

                    if (firstcolumnname == "emp_name")
                    {
                        html.Append("<td style='background-color:" + firstcolumncolor + ";' title = 'EMPID: " + dr["emp_id"].ToString() + "&#010;PHONE:" + dr["phone"].ToString() + "&#010;SUBJECT: " + dr["subject"].ToString() + "'>" + dr["" + firstcolumnname + ""].ToString() + "</td>");
                    }
                    else
                    {
                        html.Append("<td style='background-color:" + firstcolumncolor + ";'>" + dr["" + firstcolumnname + ""].ToString() + "</td>");
                    }
                    html.Append("<td style='background-color:" + secondcolumncolor + ";'>" + dr["" + oppcolumnname + ""].ToString() + "</td>");
                    html.Append("</tr>");
                    previd = id;
                    tablecreate = "0";
                }
                html.Append("</table>");
                con.Close();
                return html.ToString();
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
    }
}
            







        //            if (arlist.Contains(id))
        //            {
        //                continue;
        //            }
        //            else
        //            {
        //                arlist.Add(id);
        //            }
        //            rows = ds.Tables["results"].Select("" + edcid + " = '" + id + "'");
        //            html.Append("<table class='table table-bordered'>");
        //            var headingcolor = "";
        //            for (int i = 0; i < rows.Length; i++)
        //            {
        //                var a = rows[i][7].ToString();
        //                if (rows[i][11].ToString() == "1" & name == "CITY")
        //                {
        //                    headingcolor = "red";
        //                }
        //                else if (rows[i][1].ToString() == "0" & name == "CITY")
        //                {
        //                    headingcolor = "white";
        //                }
        //                if (rows[i][8].ToString() == "1" & name == "DEPARTMENT")
        //                {
        //                    headingcolor = "red";
        //                }
        //                else if (rows[i][8].ToString() == "0" & name == "DEPARTMENT")
        //                {
        //                    headingcolor = "white";
        //                }
        //            }
        //            html.Append("<th colspan='6' style='background-color:" + headingcolor + ";'>" + name + " NAME - " + rows[0][namerow] + " (" + rows[0][idrow] + ")</th>");
        //            html.Append("<tr>");
        //            html.Append("<th> EMP ID </th>");
        //            html.Append("<th> EMP NAME </th>");
        //            html.Append("<th> PHONE </th>");
        //            html.Append("<th> SUBJECT </th>");
        //            html.Append("<th> " + oppname + " NAME </th>");
        //            html.Append("</tr>");
        //            for (int i = 0; i < rows.Length; i++)
        //            {
        //                var empcolor = "";
        //                var cdcolor = "";
        //                if (rows[i][4].ToString() == "n")
        //                {
        //                    empcolor = "red";
        //                }
        //                else
        //                {
        //                    empcolor = "white";
        //                }
        //                if (rows[i][8].ToString() == "1" & name == "CITY")
        //                {
        //                    cdcolor = "red";
        //                }
        //                else if (rows[i][8].ToString() == "0" & name == "CITY")
        //                {
        //                    cdcolor = "white";
        //                }
        //                if (rows[i][11].ToString() == "1" & name == "DEPARTMENT")
        //                {
        //                    cdcolor = "red";
        //                }
        //                else if (rows[i][11].ToString() == "0" & name == "DEPARTMENT")
        //                {
        //                    cdcolor = "white";
        //                }
        //                html.Append("<tr>");
        //                html.Append("<td style='background-color:" + empcolor + ";'>" + rows[i][0] + "</td>");
        //                html.Append("<td style='background-color:" + empcolor + ";'>" + rows[i][1] + "</td>");
        //                html.Append("<td>" + rows[i][2] + "</td>");
        //                html.Append("<td>" + rows[i][3] + "</td>");
        //                html.Append("<td style='background-color:" + cdcolor + ";'>" + rows[i][oppid] + "</td>");
        //                html.Append("</tr>");
        //            }
        //            html.Append("</table>");
        //            html.Append("<br>");
        //        }
        //        con.Close();
        //        return html.ToString();
        //    }
        //    catch (Exception ex)
        //    {
        //        return ex.Message;
        //    }
        //}

        //[WebMethod]
        //public static string Table(dynamic dept, dynamic city)
        //{
        //    try
        //    {
        //        string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
        //        MySqlConnection con = new MySqlConnection(conString);
        //        string query = "SELECT employee.emp_id,employee.emp_name,employee.phone,employee.subject,employee.is_active,empdept.dept_id,empdept.id,department.dept_name,department.dept_is_deleted,city.city_id,city.city_name,city.city_is_deleted,employee.emp_joining_time FROM employee JOIN empdept ON employee.emp_id=empdept.emp_id JOIN city ON employee.city_id=city.city_id JOIN department ON empdept.dept_id=department.dept_id WHERE empdept.empdept_is_deleted = '0';";
        //        con.Open();
        //        MySqlDataAdapter sda = new MySqlDataAdapter(query, con);
        //        DataSet ds = new DataSet();
        //        sda.Fill(ds, "results");
        //        DataRow[] rows;
        //        StringBuilder html = new StringBuilder();
        //        ArrayList arlist = new ArrayList();
        //        foreach (DataRow dr in ds.Tables["results"].Rows)
        //        {
        //            var edcid = "";
        //            int idrow = 0;
        //            int namerow = 0;
        //            var name = "";
        //            var oppname = "";
        //            int oppid = 0;
        //            if (dept == 1)
        //            {
        //                edcid = "dept_id";
        //                idrow = 5;
        //                namerow = 7;
        //                name = "DEPARTMENT";
        //                oppname = "CITY";
        //                oppid = 10;
        //            }
        //            else if (city == 1)
        //            {
        //                edcid = "city_id";
        //                idrow = 9;
        //                namerow = 10;
        //                name = "CITY";
        //                oppname = "DEPARTMENT";
        //                oppid = 7;
        //            }
        //            var id = dr["" + edcid + ""].ToString();
        //            //string[] multipleid = id.Split('&');
        //            if (arlist.Contains(id))
        //            {
        //                continue;
        //            }
        //            else
        //            {
        //                arlist.Add(id);
        //            }
        //            rows = ds.Tables["results"].Select("" + edcid + " = '" + id + "'");
        //            html.Append("<table class='table table-bordered'>");
        //            var headingcolor = "";
        //            for (int i = 0; i < rows.Length; i++)
        //            {
        //                var a = rows[i][7].ToString();
        //                if (rows[i][11].ToString() == "1" & name == "CITY")
        //                {
        //                    headingcolor = "red";
        //                }
        //                else if (rows[i][11].ToString() == "0" & name == "CITY")
        //                {
        //                    headingcolor = "white";
        //                }
        //                if (rows[i][8].ToString() == "1" & name == "DEPARTMENT")
        //                {
        //                    headingcolor = "red";
        //                }
        //                else if (rows[i][8].ToString() == "0" & name == "DEPARTMENT")
        //                {
        //                    headingcolor = "white";
        //                }
        //            }
        //            html.Append("<th colspan='6' style='background-color:" + headingcolor + ";'>" + name + " NAME - " + rows[0][namerow] + " (" + rows[0][idrow] + ")</th>");
        //            html.Append("<tr>");
        //            html.Append("<th> EMP ID </th>");
        //            html.Append("<th> EMP NAME </th>");
        //            html.Append("<th> PHONE </th>");
        //            html.Append("<th> SUBJECT </th>");
        //            html.Append("<th> " + oppname + " NAME </th>");
        //            html.Append("</tr>");
        //            for (int i = 0; i < rows.Length; i++)
        //            {
        //                var empcolor = "";
        //                var cdcolor = "";
        //                if (rows[i][4].ToString() == "n")
        //                {
        //                    empcolor = "red";
        //                }
        //                else
        //                {
        //                    empcolor = "white";
        //                }
        //                if (rows[i][8].ToString() == "1" & name == "CITY")
        //                {
        //                    cdcolor = "red";
        //                }
        //                else if (rows[i][8].ToString() == "0" & name == "CITY")
        //                {
        //                    cdcolor = "white";
        //                }
        //                if (rows[i][11].ToString() == "1" & name == "DEPARTMENT")
        //                {
        //                    cdcolor = "red";
        //                }
        //                else if (rows[i][11].ToString() == "0" & name == "DEPARTMENT")
        //                {
        //                    cdcolor = "white";
        //                }
        //                html.Append("<tr>");
        //                html.Append("<td style='background-color:" + empcolor + ";'>" + rows[i][0] + "</td>");
        //                html.Append("<td style='background-color:" + empcolor + ";'>" + rows[i][1] + "</td>");
        //                html.Append("<td>" + rows[i][2] + "</td>");
        //                html.Append("<td>" + rows[i][3] + "</td>");
        //                html.Append("<td style='background-color:" + cdcolor + ";'>" + rows[i][oppid] + "</td>");
        //                html.Append("</tr>");
        //            }
        //            html.Append("</table>");
        //            html.Append("<br>");
        //        }
        //        con.Close();
        //        return html.ToString();
        //    }
        //    catch (Exception ex)
        //    {
        //        return ex.Message;
        //    }
        //}

//    }
//}