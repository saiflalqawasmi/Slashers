function Weapon()
    local weapon = {}
    setmetatable(weapon, { __index = Weapon })
    --

    weapon.type = "sword"
    weapon.length = 100
    weapon.damage = 10
    weapon.isactive = false

     function weapon:attack()
        print("Attacking with " .. weapon.type .. " for " .. weapon.damage .. " damage!")
    end

    function weapon:update(dt)
        -- moving sword with player
        weapon.x = player.x + 50
        weapon.y = player.y - 10

        -- moving sword while active
        if weapon.isactive then
            weapon.x = love.mouse.getX()
            weapon.y = love.mouse.getY()
        end

    end

     function weapon:draw()
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.x, self.y, self.length, 20) -- 
        love.graphics.setColor(1, 1, 1)
    end
    return weapon
end


function love.load()
    local wpn = Weapon()
    player = {
        x = 400,
        y = 300,
        speed = 200,
        weapon = {
            wpn = wpn,
            dmg = wpn.damage
        }
    }

end

function love.update(dt)
    -- movement
    if love.keyboard.isDown("up", "w") then
        player.y = player.y - player.speed * dt
    elseif love.keyboard.isDown("down", "s") then
        player.y = player.y + player.speed * dt
    end

    if love.keyboard.isDown("left", "a") then
        player.x = player.x - player.speed * dt
    
    elseif love.keyboard.isDown("right", "d") then
        player.x = player.x + player.speed * dt
    end 

    if love.mouse.isDown(1) then
        player.weapon.wpn.isactive = true
        player.weapon.wpn:attack()
    else
        player.weapon.wpn.isactive = false
    end


end

function love.draw()
    love.graphics.circle("fill", player.x, player.y, 50)

    player.weapon.wpn:draw()
end