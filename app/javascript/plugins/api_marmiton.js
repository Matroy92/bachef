import { searchRecipes, QueryBuilder, RECIPE_PRICE, RECIPE_DIFFICULTY } from 'marmiton-api'
// A query builder is provided to make complex queries
const query = qb
  .withTitleContaining('soja')
  .withoutOven()
  .withPrice(RECIPE_PRICE.CHEAP)
  .takingLessThan(45)
  .withDifficulty(RECIPE_DIFFICULTY.EASY)
  .build()
// Fetch the recipes
const recipes: Recipe[] = await searchRecipes(query)



// const searchInput = (query) => {
//     fetch(`https://www.marmiton.org/recettes/recherche.aspx?aqt=${query}`)
//       .then(response => response.json())
//       .then((data) => {
//         data.Search.forEach((result) => {
//           const recipes = `<li class="list-inline-item">
//             <p>${result.title}</p>
//           </li>`;
//           results.insertAdjacentHTML("beforeend", movie);
//         });
//       });
//     };


// const form = document.getElementById('search-recipes');
// form.addEventListener('submit', (event) => {
//   event.preventDefault();
//   list.innerHTML = '';
//   const input = document.getElementById('searchInput');
//   searchInput(input.value);
// });

//   export { searchInput };