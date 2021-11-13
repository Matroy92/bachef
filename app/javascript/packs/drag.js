

/* draggable element */
import { csrfToken } from "@rails/ujs";

function dragInit() {
  const draggableElements = document.querySelectorAll('.draggable');
  draggableElements.forEach(e => {
    e.addEventListener('dragstart', dragStart);
  });
}

function dragStart(e) {
  e.dataTransfer.setData('card', e.target.id);
  setTimeout(() => {
    e.target.classList.add('hidden');
  }, 0);
}


/* drop targets */
function dragEnd() {
  const droppableElements = document.querySelectorAll('.droppable');
  droppableElements.forEach(element => {
    element.addEventListener('dragenter', dragEnter)
    element.addEventListener('dragover', dragOver);
    element.addEventListener('dragleave', dragLeave);
    element.addEventListener('drop', drop);
  });
}

function dragEnter(e) {
  e.preventDefault();
  const id = e.dataTransfer.getData('card');
  const draggable = document.getElementById(id);
  if (e.target.classList.contains('cards-pad')) {
    //  const category = draggable.dataset.category.split("-")[1]
    //  if (e.target.id === category) {
    //    e.target.classList.add('drag-over');
    //  }
    if (!e.target.classList.contains('draggable')) {
      if (!e.target.classList.contains('card')) {
        if (!e.target.classList.contains('card-title')) {
          if (!e.target.classList.contains('column-1')) {
            if (!e.target.classList.contains('card-image')) {
              e.target.classList.add('drag-over');
            }
          }
        }
      }
    }
  }
}

function dragOver(e) {
  e.preventDefault();
  const id = e.dataTransfer.getData('card');
  // console.log("id", id)
  // const draggable = document.getElementById(id);
  // columns vers checklist
  if (e.target.classList.contains("card_checklist")) {
    e.target.classList.add('drag-over');


  }

  // checklist vers columns

  // if (e.target.classList.contains('cards-pad')) {
  //   // const category = draggable.dataset.category.split("-")[1]
  //   // if (e.target.id === category) {
  //   //   e.target.classList.add('drag-over');
  //   // }
  //   if (!e.target.classList.contains('draggable')) {
  //     console.log("1")

  //     if (!e.target.classList.contains('card')) {
  //       console.log("2")
  //       if (!e.target.classList.contains('card-title')) {
  //         console.log("3")
  //         if (!e.target.classList.contains('column-1')) {
  //           console.log("4")
  //           if (!e.target.classList.contains('card-image')) {
  //             console.log("5")
  //             e.target.classList.add('drag-over');
  //           }
  //         }
  //       }
  //     }
  //   }
  // }
}

function dragLeave(e) {

  if (!e.target.classList.contains("card_checklist")) {
    const checklist = document.querySelector(".card_checklist");
    if (checklist.classList.contains("drag-over")) {
      checklist.classList.remove("drag-over")
    }
    // e.target.classList.add('drag-over');
  }
  // const id = e.dataTransfer.getData('card');
  // const draggable = document.getElementById(id);
  // if (e.target.classList.contains('cards-pad')) {
  //   const category = draggable.dataset.category.split("-")[1]
  //   if (e.target.id === category) {
  //     e.target.classList.remove('drag-over');
  //   }
  //   if (!e.target.classList.contains('card')) {
  //     if (!e.target.classList.contains('card-title')) {
  //       if (!e.target.classList.contains('column-1')) {
  //         if (!e.target.classList.contains('card-image')) {
  //           e.target.classList.remove('drag-over');
  //         }
  //       }
  //     }
  //   }
  // }
}

function drop(e) {
  e.target.classList.remove('drag-over');

  // get the draggable element
  const id = e.dataTransfer.getData('card');
  const draggable = document.getElementById(id);
  if (e.target.classList.contains('card_checklist')) {
    if (!e.target.classList.contains('card')) {
      if (!e.target.classList.contains('card-title')) {
        if (!e.target.classList.contains('column-1')) {
          if (!e.target.classList.contains('card-image')) {
            console.log(draggable)
            e.target.appendChild(draggable);
          }
        }
      }
    }
  }
  else {
    const category = draggable.dataset.category.split("-")[1]
    if (e.target.id === category) {
      e.target.appendChild(draggable);
    }
  }

  // display the draggable element
  draggable.classList.remove('hidden');
}

function cardSelection() {
  const form = document.querySelector(".edit_game")
  console.log(form);

  form.addEventListener("submit", (event) => {
    event.preventDefault()

    const selectedCards = document.querySelectorAll('.card_checklist .draggable');

    const selectedCardsIds = Array.from(selectedCards).map((element) => {
      return element.dataset.id
    })
    let formData = new FormData();
    formData.append('card_ids', selectedCardsIds)
    fetch(form.action, {
      method: 'POST',
      headers: {
        'Accept': 'application/html', 'X-CSRF-Token': csrfToken()
      },
      body: formData,
      redirect: 'follow'
    })
      .then(response => response.json())
      .then((data) => {
        window.location.href = data.url;
      })
  })
}

export { dragInit, dragEnd, cardSelection };
//export { dragEnter };
//export { dragLeave };
//export { drop };