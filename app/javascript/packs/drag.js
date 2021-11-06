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
  e.target.classList.add('drag-over');
}

function dragOver(e) {
  e.preventDefault();
  e.target.classList.add('drag-over');
}

function dragLeave(e) {
  e.target.classList.remove('drag-over');
}

function drop(e) {
  e.target.classList.remove('drag-over');

  // get the draggable element
  const id = e.dataTransfer.getData('card');
  console.log(id)
  window.lol = e
  const draggable = document.getElementById(id);

  // add it to the drop target
  e.target.appendChild(draggable);

  // display the draggable element
  draggable.classList.remove('hidden');
}

export { dragInit, dragEnd };
//export { dragEnter };
//export { dragLeave };
//export { drop };
