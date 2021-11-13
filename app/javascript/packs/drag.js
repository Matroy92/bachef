/* draggable element */

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
  if (!e.target.classList.contains('card')) {
    if (!e.target.classList.contains('card-title')) {
      if (!e.target.classList.contains('column-1')) {
        if (!e.target.classList.contains('card-image')) {
          e.target.classList.add('drag-over');
        }
      }
    }
  }
  else {
    const category = draggable.dataset.category.split("-")[1]
    if (e.target.id === category) {
      e.target.classList.add('drag-over');
    }
  }
}

function dragOver(e) {
  e.preventDefault();
  if (!e.target.classList.contains('card')) {
    if (!e.target.classList.contains('card-title')) {
      if (!e.target.classList.contains('column-1')) {
        if (!e.target.classList.contains('card-image')) {
          e.target.classList.add('drag-over');
        }
      }
    }
  }
  else {
    const category = draggable.dataset.category.split("-")[1]
    if (e.target.id === category) {
      e.target.classList.add('drag-over');
    }
  }
}

function dragLeave(e) {
  if (!e.target.classList.contains('card')) {
    if (!e.target.classList.contains('card-title')) {
      if (!e.target.classList.contains('column-1')) {
        if (!e.target.classList.contains('card-image')) {
          e.target.classList.remove('drag-over');
        }
      }
    }
  }
  else {
    const category = draggable.dataset.category.split("-")[1]
    if (e.target.id === category) {
      e.target.classList.remove('drag-over');
    }
  }
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
            e.target.appendChild(draggable);
            console.log(draggable)
            console.log(e.target)
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

export { dragInit, dragEnd };
//export { dragEnter };
//export { dragLeave };
//export { drop };
