class Janken
  HAND = {
    g: {
      call: 'グー',
      against: {
        g: 0,
        c: 1,
        p: -1,
      },
    },
    c: {
      call: 'チョキ',
      against: {
        g: -1,
        c: 0,
        p: 1,
      },
    },
    p: {
      call: 'パー',
      against: {
        g: 1,
        c: -1,
        p: 0,
      },
    },
  }

  def initialize
    @result = { you: [], opponent: [] }
  end

  def start
    times_for_game = select_times_for_game
    play_game('じゃんけん') while @result[:you].size < times_for_game
    show_final_result
  end

  def select_times_for_game
    puts '何本勝負？(press 1 or 3 or 5)'
    selected_number = gets.to_i
    if selected_number == 1 || selected_number == 3 || selected_number == 5
      puts "#{selected_number}本勝負を選びました。"
      times_for_game = selected_number
    else
      puts '入力が間違っています。入力し直してください。'
      select_times_for_game
    end
  end

  def play_game(start_with)
    puts "#{@result[:you].size + 1}本目"
    your_hand = select_your_hand(start_with)
    opponents_hand = get_opponents_hand
    show_temporary_result(your_hand, opponents_hand)
    if hands_draw?(your_hand, opponents_hand)
      play_game('あいこで')
    else
      @result[:you] << HAND[your_hand][:against][opponents_hand]
      @result[:opponent] << HAND[opponents_hand][:against][your_hand]
    end
  end

  def select_your_hand(start_with)
    puts "#{start_with}…(press g or c or p)"
    your_hand = gets.chomp.to_sym
    if your_hand == :g || your_hand == :c || your_hand == :p
      your_hand
    else
      puts '入力が間違っています。入力し直してください。'
      select_your_hand(start_with)
    end
  end

  def get_opponents_hand
    opponents_hand = %i[g c p].sample
  end

  def hands_draw?(your_hand, opponents_hand)
    your_hand == opponents_hand
  end

  def show_temporary_result(your_hand, opponents_hand)
    puts "CPU...#{HAND[opponents_hand][:call]}"
    puts "あなた...#{HAND[your_hand][:call]}"
  end

  def show_final_result
    if you_win?
      puts '勝ち！'
    else
      puts '負け！'
    end
    puts get_score
  end

  def you_win?
    @result[:you].sum > @result[:opponent].sum ? true : false
  end

  def get_score
    your_score = @result[:you]
    win_scores = your_score.select { |score| score == 1 }
    lose_scores = your_score.select { |score| score == -1 }
    "#{win_scores.sum}勝#{lose_scores.sum * -1}負"
  end

  def show_for_test
    [1, 2, 3, 4, 5].select { |num| num == 1 }
  end
end
