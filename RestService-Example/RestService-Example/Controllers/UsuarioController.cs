using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using RestService_Example.Models;

namespace RestService_Example.Controllers
{
    [RoutePrefix("estabelecimentos")]
    public class UsuarioController : ApiController
    {
        private static List<UsuarioModel> listaUsuarios = new List<UsuarioModel>();

        [AcceptVerbs("POST")]
        [Route("listar-centrais")]
        public MensagemModel listarcentrais(UsuarioModel usuario)
        {

            listaUsuarios.Add(usuario);

            MensagemModel mensagem = new MensagemModel();
            //return "Usuário cadastrado com sucesso!";
            if (usuario.Codigo == 3 && usuario.Nome.ToLower() == "rafael")
            {
                mensagem.codigo = 0;
                mensagem.mensagem = "Usuário cadastrado com sucesso!";
            }
            else
            {
                mensagem.codigo = 1;
                mensagem.mensagem = "ERRO ao cadastrar usuário!";
            }

            return mensagem;
        }

        [AcceptVerbs("POST")]
        [Route("AlterarUsuario")]
        public string AlterarUsuario(UsuarioModel usuario)
        {

            listaUsuarios.Where(n => n.Codigo == usuario.Codigo)
                         .Select(s => 
            {
                s.Codigo = usuario.Codigo;
                s.Login = usuario.Login;
                s.Nome = usuario.Nome;

                return s;

            }).ToList();

            return "Usuário alterado com sucesso!";
        }

        [AcceptVerbs("DELETE")]
        [Route("ExcluirUsuario/{codigo}")]
        public string ExcluirUsuario(int codigo)
        {

            UsuarioModel usuario = listaUsuarios.Where(n => n.Codigo == codigo)
                                                .Select(n => n)
                                                .First();

            listaUsuarios.Remove(usuario);

            return "Registro excluido com sucesso!";
        }

        [AcceptVerbs("GET")]
        [Route("ConsultarUsuarioPorCodigo/{codigo}")]
        public UsuarioModel ConsultarUsuarioPorCodigo(int codigo)
        {

            UsuarioModel usuario = listaUsuarios.Where(n => n.Codigo == codigo)
                                                .Select(n => n)
                                                .FirstOrDefault();

            return usuario;
        }

        [AcceptVerbs("GET")]
        [Route("ConsultarUsuarios")]
        public List<UsuarioModel> ConsultarUsuarios()
        {
            return listaUsuarios;
        }
    }
}
