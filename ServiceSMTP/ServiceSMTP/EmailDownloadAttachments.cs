using OpenPop.Mime;
using OpenPop.Pop3;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Text;

namespace ServiceSMTP
{
    public static class EmailDownloadAttachments
    {
        //Download attachments
        public static void DownloadAttachs()
        {
            AppSettings appSettings = new AppSettings
            {
                Host = ConfigurationSettings.AppSettings["host"].ToString(),
                Port = Convert.ToInt32(ConfigurationSettings.AppSettings["port"]),
                UserName = ConfigurationSettings.AppSettings["userName"].ToString(),
                Password = ConfigurationSettings.AppSettings["password"].ToString(),
                SubjectFindEmail = ConfigurationSettings.AppSettings["subjectFindMail"].ToString(),
                PathSendAttachment = ConfigurationSettings.AppSettings["PathSendAttachment"].ToString(),
                PathLog = ConfigurationSettings.AppSettings["pathLog"].ToString(),
                SSL = true,
                FileTypes = ConfigurationSettings.AppSettings["fileTypes"].ToString().Split(',')
            };

            try
            {
                VerifyIfFoldersExists(new string[] { appSettings.PathSendAttachment, appSettings.PathLog });

                List<Message> lstMessages = GetAllMessages(appSettings);
                if (lstMessages != null && lstMessages.Count > 0)
                {
                    List<Message> messagesFiltered = GetMessagesFiltered(lstMessages, appSettings.SubjectFindEmail);
                    if (messagesFiltered != null && messagesFiltered.Count > 0)
                    {
                        DownloadAttachments(messagesFiltered, appSettings);
                    }
                    else
                    {
                        Log($"We could not find any emails with subject: {appSettings.SubjectFindEmail}.", appSettings, false);
                    }
                }
                else
                {
                    Log($"We could not find emails on account: {appSettings.UserName}.", appSettings, false);
                }
            }
            catch (Exception ex)
            {
                Log(ex.Message, appSettings);
            }
        }

        //Gererate log erro
        private static void Log(string message, AppSettings appSettings, bool logErro = true)
        {
            StreamWriter valor = new StreamWriter(logErro ? appSettings.PathLog + "LogErro.txt" : appSettings.PathLog + "LogOperacao.txt", true, Encoding.ASCII);
            valor.Write($"Date: {DateTime.Now.ToString("dd / MM / yyyy hh: mm:ss")}" + Environment.NewLine);
            if (logErro)
            {
                valor.Write($"Username: {appSettings.UserName}" + Environment.NewLine);
                valor.Write($"Host: {appSettings.Host}" + Environment.NewLine);
                valor.Write($"Port: {appSettings.Port}" + Environment.NewLine);
            }
            valor.Write("Message: " + message + Environment.NewLine + Environment.NewLine);
            valor.Close();
        }

        //Download attachments
        private static void DownloadAttachments(List<Message> messagesFiltered, AppSettings appSettings)
        {
            int countEmails = 0;
            int countAttachments = 0;
            foreach (Message msg in messagesFiltered)
            {
                countEmails++;
                var att = msg.FindAllAttachments();
                foreach (var ado in att)
                {
                    string fileName = $"{ado.FileName.Split('.')[0]}-{DateTime.Now.ToString("dd-MM-yyyy")}.{ado.FileName.Split('.')[1]}";
                    if (appSettings.FileTypes.Length == 0)
                    {
                        countAttachments++;
                        ado.Save(new System.IO.FileInfo(System.IO.Path.Combine(appSettings.PathSendAttachment, fileName)));
                    }
                    else
                    {
                        if (appSettings.FileTypes.Contains(ado.ContentType.Name.Split('.')[1]))
                        {
                            countAttachments++;
                            ado.Save(new System.IO.FileInfo(System.IO.Path.Combine(appSettings.PathSendAttachment, fileName)));
                        }
                    }
                }
            }
            Log($"Emails found: {countEmails}, Files downloaded: {countAttachments}.", appSettings, false);
        }

        //Verify if folders exists, if not, make a folder
        private static void VerifyIfFoldersExists(string[] folders)
        {
            foreach (var item in folders)
            {
                System.IO.DirectoryInfo dircVerify = new System.IO.DirectoryInfo(item);
                if (!dircVerify.Exists)
                    dircVerify.Create();
            }
        }

        //Filter messages by sybject
        private static List<Message> GetMessagesFiltered(List<Message> lstMessages, string subjectFindEmail)
        {
            return lstMessages.Where(l => l.Headers.Subject.Contains(subjectFindEmail)).ToList<Message>();
        }

        //Get all messages
        private static List<Message> GetAllMessages(AppSettings appSettings)
        {
            // The client disconnects from the server when being disposed
            using (Pop3Client client = new Pop3Client())
            {
                // Connect to the server
                client.Connect(appSettings.Host, appSettings.Port, appSettings.SSL);

                // Authenticate ourselves towards the server
                client.Authenticate(appSettings.UserName, appSettings.Password);

                // Get the number of messages in the inbox
                int messageCount = client.GetMessageCount();

                // We want to download all messages
                List<Message> allMessages = new List<Message>(messageCount);

                // Messages are numbered in the interval: [1, messageCount]
                // Ergo: message numbers are 1-based.
                // Most servers give the latest message the highest number
                for (int i = messageCount; i > 0; i--)
                {
                    allMessages.Add(client.GetMessage(i));
                }

                //Disconnect
                client.Disconnect();

                // Now return the fetched messages
                return allMessages;
            }
        }
    }
}
