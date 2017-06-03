using Xamarin.Forms;
using System.Threading.Tasks;
using System.Collections.ObjectModel;

namespace MonkeyHubApp.ViewModels
{
    public class MainViewModel : BaseViewModel
    {
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

        public ObservableCollection<string> Resultados { get; }

        public Command SearchCommand { get; }

        public MainViewModel()
        {
            SearchCommand = new Command(ExecuteSearchCommand, CanExecuteSearchCommand);
        }

        async void ExecuteSearchCommand()
        {
            //await Task.Delay(1000);
            bool resposta =  await App.Current.MainPage.DisplayAlert("MonkeyHubApp"
                , $"Você pesquisou por '{SearchTerm}'? ", "Sim", "Não");

            if (resposta)
                await App.Current.MainPage.DisplayAlert("MonkeyHubApp", "Obrigado.", "OK");
            else
                await App.Current.MainPage.DisplayAlert("MonkeyHubApp", "De nada.", "OK");
        }

        bool CanExecuteSearchCommand()
        {
            return string.IsNullOrWhiteSpace(SearchTerm) == false;
            ;
        }
    }
}
