using Newtonsoft.Json;

namespace PersonelTakip.Classes
{
    public class ApiService
    {
        private readonly HttpClient _httpClient;

        public ApiService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<List<string>> GetUniversitelerAsync()
        {
            var response = await _httpClient.GetStringAsync("http://universities.hipolabs.com/search?country=Turkey");

            var universiteler = JsonConvert.DeserializeObject<List<Universite>>(response);

            var universiteIsimleri = universiteler?.Select(u => u.Name).ToList();

            return universiteIsimleri;
        }
    }

    public class Universite
    {
        public string Name { get; set; }
    }
}
