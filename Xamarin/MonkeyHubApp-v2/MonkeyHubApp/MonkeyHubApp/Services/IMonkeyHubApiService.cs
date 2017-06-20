using System.Threading.Tasks;
using System.Collections.Generic;
using MonkeyHubApp.Models;

namespace MonkeyHubApp.Services
{
    public interface IMonkeyHubApiService
    {
        Task<List<Tag>> GetTagsAsync();

        Task<List<Content>> GetContentsByTagIdAsync(string tagId);

        Task<List<Content>> GetContentsByFilterAsync(string filter);
    }
}
