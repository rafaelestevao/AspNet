using System;
using System.Text;

namespace WebApplication1.Models
{
    public class UrlBuilder
    {
        private string _argPref;
        private StringBuilder _url;

        public UrlBuilder(String pageName)
        {
            _url = new StringBuilder();
            _argPref = "?";
            _url.Append(pageName);
        }

        public void AppendArgument(string name, string value)
        {
            _url.Append(_argPref);
            _url.Append(name);
            _url.Append("=");
            _url.Append(value);
            _argPref = "&";
        }

        public void AppendArgument(string name, int value)
        {
            AppendArgument(name, value.ToString());
        }

        public void AppendSqlType(string where)
        {
            AppendArgument("SqlType", where);
        }

        public void AppendPrevHID(int histryID)
        {
            AppendArgument("HID", histryID.ToString());
        }

        //public String GetPrevPageURL(int HID, DBConnection dBConn)
        //{
        //    string returnUrl = "/default.aspx";

        //    tbLogAcesso logAcesso = new tbLogAcesso(dBConn);
        //    logAcesso.OpenPK(HID);

        //    if (logAcesso.Read())
        //    {
        //        returnUrl = logAcesso.URLPagina.Value;
        //    }
        //    logAcesso.Close();

        //    return returnUrl;
        //}

        public override String ToString()
        {
            return _url.ToString();
        }
    }
}