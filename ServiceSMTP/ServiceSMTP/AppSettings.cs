using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ServiceSMTP
{
    public class AppSettings
    {
        public string Host { get; set; }
        public int Port { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public string SubjectFindEmail { get; set; }
        public string PathSendAttachment { get; set; }
        public string PathLog { get; set; }
        public bool SSL { get; set; }
        public string[] FileTypes { get; set; }
    }
}
