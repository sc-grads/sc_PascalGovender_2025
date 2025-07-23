import random
import sys

print("Welcome to Rock, Paper, Scissor!")
moves: dict = {'rock': '🪨', 'paper' : '📜', 'scissor': '✂️'}
valid_moves : list[str] = list(moves.keys())

while True:
    user_move = input("Rock, paper or scissor? >> ").lower()
    if user_move == "exit":
        print("Thank you for playing !")
        sys.exit()

    if user_move not in valid_moves:
        print("Invalid move. Please try again.")
        continue

    ai_move = random.choice(valid_moves)

    print('----')
    print(f'You: {moves[user_move]}')
    print(f'AI: {moves[ai_move]}')
    print('----')

    if user_move == ai_move:
        print('Its a tie!')
    elif user_move == 'rock' and ai_move == 'scissor':
        print('You win!')
    elif user_move == 'scissor' and ai_move == 'paper':
        print('You win!')
    elif user_move == 'paper' and ai_move == 'rock':
        print('You win!')
    else:
        print("AI wins...")