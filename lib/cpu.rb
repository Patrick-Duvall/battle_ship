class CPU

def initialize(cpuboard, playerboard)
  @cpuboard = cpuboard
  @playerboard = playerboard
  @lasthit = nil
  @lastshotwashit = false
  @targetships = []
end

## Can build array with Nils BUT determine_cpu_placement rejects them
  def cpu_placement_direction(first_square)
    case rand(4)
    when 0
      square = first_square[0] + ((first_square[1].to_i) + 1).to_s
    when 1
      square = first_square[0] + ((first_square[1].to_i) - 1).to_s
    when 2
      square = ((first_square[0].ord) + 1).to_s + first_square[1]
    when 3
      square = ((first_square[0].ord) - 1).to_s + first_square[1]
    end
  end

  def determine_cpu_placement(ship_array)
    @targetships = ship_array
    i = 0
    until i == ship_array.length do
      first_square = @cpuboard.cells.keys.sample
      placement_array = [first_square]
      (ship_array[i].health-1).times do |coordinate|
        first_square = cpu_placement_direction(first_square)
        placement_array << first_square
      end
      if @cpuboard.valid_placement?(ship_array[i], placement_array)
        @cpuboard.place(ship_array[i], placement_array)
         i +=1
      end
    end
  end

  def cpu_shot
    chosen = false
    until chosen == true
      coordinate = @playerboard.cells.keys.sample
      chosen = true if @playerboard.valid_coordinate?(coordinate)
    end
    if @lastshotwashit == true && @lasthit != nil
      chosen = false
      until chosen == true
        case rand(4) # see if remember last
        when 0
          target = @lasthit[0] + ((@lasthit[1].to_i) + 1).to_s
        when 1
          target = @lasthit[0] + ((@lasthit[1].to_i) -1 ).to_s
        when 2
          target = ((@lasthit[0].ord) + 1).chr + @lasthit[1]
        when 3
          target = ((@lasthit[0].ord) - 1).chr + @lasthit[1]
        end
        coordinate = target
        chosen = true if @playerboard.valid_coordinate?(coordinate)
      end
    end
    @playerboard.cells[coordinate].fire_upon
    cellstate = @playerboard.cells[coordinate].render
    case
      when cellstate == "M"
        puts "My shot on #{coordinate} was a miss."
        @lastshotwashit = false
      when cellstate == "H"
        puts "My shot on #{coordinate} was a hit."
        @lasthit = coordinate
        @lastshotwashit = true
      when cellstate == "X"
        puts "My shot on #{coordinate} sunk your #{@playerboard.cells[coordinate].ship.name}!"
        @lasthit = nil
        @lastshotwashit = false
    end
  end
end
