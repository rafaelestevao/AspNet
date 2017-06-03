using Xamarin.Forms;
using System.Threading.Tasks;
using System.Collections.ObjectModel;
using System.IO;
using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json;
using System.Collections.Generic;
using MonkeyHubApp.Models;

namespace MonkeyHubApp.ViewModels
{
    public class MainViewModel : BaseViewModel
    {
        private const string BaseUrl = "https://monkey-hub-api.azurewebsites.net/api/";

        public async Task<List<Tag>> GetTagsAsync()
        {
            var httpClient = new HttpClient();
            httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            var response = await httpClient.GetAsync($"{BaseUrl}Tags").ConfigureAwait(false);

            if (response.IsSuccessStatusCode)
            {
                using (var responseStream = await response.Content.ReadAsStreamAsync().ConfigureAwait(false))
                {
                    return JsonConvert.DeserializeObject<List<Tag>>(
                        await new StreamReader(responseStream)
                            .ReadToEndAsync().ConfigureAwait(false));
                }
            }

            return null;
        }


        private string _searchterm;

        public string SearchTerm
        {
            get { return _searchterm; }
            set
            {
                if(SetProperty(ref _searchterm, value))
                    SearchCommand.ChangeCanExecute();
            }
        }

        public ObservableCollection<Tag> Resultados { get; }

        public Command SearchCommand { get; }

        public MainViewModel()
        {
            SearchCommand = new Command(ExecuteSearchCommand, CanExecuteSearchCommand);
            Resultados = new ObservableCollection<Tag>();
        }

        async void ExecuteSearchCommand()
        {
            //await Task.Delay(1000);
            bool resposta =  await App.Current.MainPage.DisplayAlert("MonkeyHubApp"
                , $"Você pesquisou por '{SearchTerm}'? ", "Sim", "Não");

            if (resposta)
            {
                await App.Current.MainPage.DisplayAlert("MonkeyHubApp", "Obrigado.", "OK");
                var tagsRetornadas = await GetTagsAsync();

                Resultados.Clear();
                if (tagsRetornadas != null)
                {
                    foreach (var tag in tagsRetornadas)
                    {
                        Resultados.Add(tag);
                    }
                }
            }
            else
            {
                await App.Current.MainPage.DisplayAlert("MonkeyHubApp", "De nada.", "OK");
                Resultados.Clear();
            }
                
        }

        bool CanExecuteSearchCommand()
        {
            return string.IsNullOrWhiteSpace(SearchTerm) == false;
            ;
        }
    }
}
