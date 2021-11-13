

/* draggable element */
import { csrfToken } from "@rails/ujs";

function dragInit() {
  const draggableElements = document.querySelectorAll('.draggable');
  console.log(draggableElements)
  draggableElements.forEach(e => {
    e.addEventListener('dragstart', dragStart);
  });
}

function dragStart(e) {
  e.dataTransfer.setData('card', e.target.id);
  setTimeout(() => {
    e.currentTarget.classList.add('hidden');
  }, 0);
}


/* drop targets */
function dragEnd() {
  const droppableElements = document.querySelectorAll('.droppable');
  droppableElements.forEach(element => {
    element.addEventListener('dragover', dragOver);
    element.addEventListener('dragleave', dragLeave);
    element.addEventListener('drop', drop);
  });
}

function dragOver(e) {
  e.preventDefault();
  let id = e.dataTransfer.getData('card');
  if (!id) {
    e.dataTransfer.setData('card', e.target.id);
    let id = e.dataTransfer.getData('card');
  }

  const draggable = document.getElementById(id);

  // columns vers checklist
  if (e.target.classList.contains("card_checklist")) {
    e.target.classList.add('drag');
  }
}

function dragLeave(e) {

  if (!e.target.classList.contains("card_checklist")) {
    const checklist = document.querySelector(".card_checklist");
    if (checklist.classList.contains("drag")) {
      checklist.classList.remove("drag")
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
  e.target.classList.remove('drag');

  // get the draggable element
  const id = e.dataTransfer.getData('card');
  const draggable = document.getElementById(id);
  if (e.currentTarget.classList.contains('card_checklist')) {
    e.currentTarget.appendChild(draggable);
  }
  else {
    const category = draggable.dataset.category.split("-")[1]
    if (e.currentTarget.id === category) {
      e.currentTarget.appendChild(draggable);
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