using System;
using System.Configuration;
using System.Net;
//using Abbvie.DataAccess.Repositories;

namespace WebApplication1.Models
{
    /// <summary>
    /// Manage a session for communications with OOD Web Services
    /// </summary>
    public class OracleSession : IDisposable
    {
        private const string HttpBase = "https://";

        private string UserName { get; }
        private string Password { get; }
        private string ServerUrl { get; }
        private string SessionId { get; set; }

        private Cookie _cookie;

        private OracleSession(string serverUrl, string userName, string password)
        {
            ServerUrl = serverUrl;
            UserName = userName;
            Password = password;
        }

        public static OracleSession EstabilishOracleSession()
        {
            //var serverUrl = ConfigurationManager.AppSettings["OOD_Server"];
            //var credentials = CredentialsRepository.GetOracleCredentials();

            var session = new OracleSession("secure-slsomxvha.crmondemand.com", "ABBVIEBRAZIL/INTEGRACAO", "$Brteam&QA@1710");
            session.Establish();

            return session;
        }

        private void Establish()
        {
            // Check that username and password have been specified
            CheckUsernamePassword();

            // create a container for an HTTP request
            var loginUrl = HttpBase + ServerUrl + "/Services/Integration?command=login";
            var req = (HttpWebRequest)WebRequest.Create(loginUrl);

            // username and password are passed as HTTP headers
            req.Headers.Add("UserName", UserName);
            req.Headers.Add("Password", Password);

            // cookie container has to be added to request in order to 
            // retrieve the cookie from the response. 
            req.CookieContainer = new CookieContainer();

            // make the HTTP call
            var resp = (HttpWebResponse)req.GetResponse();
            if (resp.StatusCode == HttpStatusCode.OK)
            {
                // store cookie for later
                _cookie = resp.Cookies["JSESSIONID"];
                if (_cookie == null)
                {
                    throw new Exception("No JSESSIONID cookie found in log-in response!");
                }
                SessionId = _cookie.Value;
            }
        }

        public void Dispose()
        {
            //destroy the session only if it is active
            if (SessionId != null)
            {
                // create a container for an HTTP request
                var logoffUrl = HttpBase + ServerUrl + "/Services/Integration?command=logoff";
                var req = (HttpWebRequest)WebRequest.Create(logoffUrl);

                // reuse the cookie that was received at Login
                req.CookieContainer = new CookieContainer();
                req.CookieContainer.Add(_cookie);

                // make the HTTP call
                var resp = (HttpWebResponse)req.GetResponse();
                if (resp.StatusCode != HttpStatusCode.OK)
                {
                    throw new Exception("Logging off failed!");
                }
                // forget current session id
                SessionId = null;
            }
        }

        public CookieContainer GetCookieContainer()
        {
            // Returns a CookieContainer that can be used in a web services call
            if (SessionId == null)
            {
                throw new Exception("No session has been established!");
            }
            CookieContainer cc = new CookieContainer();
            Cookie sCookie = new Cookie("JSESSIONID", SessionId);
            sCookie.Domain = ".siebel.com";
            cc.Add(sCookie);

            return cc;
        }

        public string GetUrl()
        {
            if (SessionId == null)
            {
                throw new Exception("No session has been established!");
            }
            return HttpBase + ServerUrl + "/Services/Integration;jsessionid=" + SessionId;
        }

        private void CheckUsernamePassword()
        {
            if (UserName == null) { throw new Exception("Username not specified!"); }
            if (Password == null) { throw new Exception("Password not specified!"); }
        }
    }
}