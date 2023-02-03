namespace BackendApi.Models.Old;

public class Pizza
{
        Pizza(){}
        Pizza(string? name, Sauce? sauce)
        {
                Name = name;
                Sauce = sauce;
        }
    
        public int Id { get; set; }
        
        public string? Name { get; set; }

        public Sauce? Sauce { get; set; }
    
        public ICollection<Topping>? Toppings { get; set; }
    
}
