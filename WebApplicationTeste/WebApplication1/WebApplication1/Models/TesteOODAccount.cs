using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication1.Models
{
    public class TesteOODAccount
    {
        //public void teste()
        //{
        //    OODAccount2.Account proxy = new OODAccount2.Account();
        //    OODAccount2.AccountWS_AccountUpdate_Input param = new OODAccount2.AccountWS_AccountUpdate_Input();
        //    param.ListOfAccount = new OODAccount2.Account1[1];
        //    param.ListOfAccount[0] = new OODAccount2.Account1();
        //    param.ListOfAccount[0].AccountType = "Paciente";
        //    param.ListOfAccount[0].AccountId = "xpto";
        //    param.ListOfAccount[0].bConsentimiento_Verbal = "1"; //VERIFICAR, NÃO ESTÁ ENVIANDO PARA ORACLE, JÁ TENTEI OUTROS VALOES (S/N, 0/1, T/F, C/E);
        //    param.ListOfAccount[0].plConsentimiento_Informado = "Sim";
        //    //param.ListOfAccount[0];

        //    proxy.Url = session.GetUrl();
        //    proxy.CookieContainer = session.GetCookieContainer();
        //    proxy.AccountUpdate(param);
        //}


        //public void testeServiceRequest()
        //{
        //    OODServiceRequest.ServiceRequest prxySrvc = new OODServiceRequest.ServiceRequest();
        //    OODServiceRequest.ServiceRequestWS_ServiceRequestUpdate_Input qryParam = new OODServiceRequest.ServiceRequestWS_ServiceRequestUpdate_Input();
        //    qryParam.ListOfServiceRequest = new OODServiceRequest.ServiceRequest1[1];
        //    qryParam.ListOfServiceRequest[0] = new OODServiceRequest.ServiceRequest1();
        //    qryParam.ListOfServiceRequest[0].SRNumber = "gasdsdg21515";
        //    qryParam.ListOfServiceRequest[0].Description = "Foi efetuado o Aceite eletrônico.";
        //    qryParam.ListOfServiceRequest[0].Status = "Closed";
        //    qryParam.ListOfServiceRequest[0].dtData_de_envio_de_consentimento_via_email = "";
        //    //Data de envio do consententimento (envio do e-mail) qryParam.ListOfServiceRequest[0].dtData_de_envio_de_consentimento_via_email

        //    qryParam.ListOfServiceRequest[0].dtData_de_recebimento_do_consentimento_via_email = "";
        //    //Data do aceite   qryParam.ListOfServiceRequest[0].dtData_de_recebimento_do_consentimento_via_email

        //    prxySrvc.Url = session.GetUrl();
        //    prxySrvc.CookieContainer = session.GetCookieContainer();
        //    prxySrvc.ServiceRequestUpdate(qryParam);
        //}


    }
}