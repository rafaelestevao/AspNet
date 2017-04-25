using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace GP_Extranet_Mock_WebApi_Rest.Models
{
    public class TimeStamp
    {
        public long GetTimeStamp()
        {
            /// <summary>
            /// gero um timestamp a partir do datetime.now
            /// </summary>
            long unixTimeStamp;
            DateTime currentTime = DateTime.Now;
            DateTime zuluTime = currentTime.ToUniversalTime();
            DateTime unixEpoch = new DateTime(1970, 1, 1);
            unixTimeStamp = (long)(zuluTime.Subtract(unixEpoch)).TotalMilliseconds;
            return unixTimeStamp;
        }

        public long DateTimeToTimeStamp(DateTime date)
        {
            /// <summary>
            /// gero um timestamp a partir de uma data que foi passada
            /// </summary>
            long unixTimeStamp;
            DateTime currentTime = date;
            DateTime zuluTime = currentTime.ToUniversalTime();
            DateTime unixEpoch = new DateTime(1970, 1, 1);
            unixTimeStamp = (long)(zuluTime.Subtract(unixEpoch)).TotalMilliseconds;
            return unixTimeStamp;
        }

        public DateTime TimeStampToDateTime(double unixTimeStamp)
        {
            /// <summary>
            /// Converto um timestamp para datetime
            /// </summary>
            System.DateTime dtDateTime = new DateTime(1970, 1, 1);
            dtDateTime = dtDateTime.AddMilliseconds(unixTimeStamp).ToLocalTime();
            return dtDateTime;
        }
    }
}