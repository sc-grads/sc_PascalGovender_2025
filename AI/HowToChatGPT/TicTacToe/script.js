const cells = document.querySelectorAll('.cell');
const statusText = document.getElementById('status');
const resultScreen = document.getElementById('resultScreen');
const resultMessage = document.getElementById('resultMessage');
const newGameBtn = document.getElementById('newGameBtn');
const gameScreen = document.getElementById('gameScreen');

let currentPlayer = 'X';
let gameActive = true;
let board = ["", "", "", "", "", "", "", "", ""];

const winningConditions = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
];

function handleCellClick(e) {
  const cell = e.target;
  const index = cell.getAttribute('data-index');

  if (board[index] !== "" || !gameActive) return;

  board[index] = currentPlayer;
  cell.setAttribute('data-symbol', currentPlayer);

  if (checkWinner()) {
    endGame(`Player ${currentPlayer} wins!`);
  } else if (board.every(cell => cell !== "")) {
    endGame("It's a draw!");
  } else {
    currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
    statusText.textContent = `Player ${currentPlayer}'s turn`;
  }
}

function checkWinner() {
  return winningConditions.some(([a, b, c]) =>
    board[a] && board[a] === board[b] && board[b] === board[c]
  );
}

function endGame(message) {
  gameActive = false;
  resultMessage.textContent = message;
  gameScreen.style.display = 'none';
  resultScreen.style.display = 'block';
}

function startNewGame() {
  board = ["", "", "", "", "", "", "", "", ""];
  gameActive = true;
  currentPlayer = 'X';
  statusText.textContent = `Player ${currentPlayer}'s turn`;
  cells.forEach(cell => cell.removeAttribute('data-symbol'));
  resultScreen.style.display = 'none';
  gameScreen.style.display = 'block';
}

cells.forEach(cell => cell.addEventListener('click', handleCellClick));
newGameBtn.addEventListener('click', startNewGame);
