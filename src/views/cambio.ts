import { genders  } from '@prisma/client';


export default {
  render(cambio: Person) {
    return {

    };
  },

  renderMany(cambio: Person[]) {
    return people.map(person => this.render(person));
  }
}