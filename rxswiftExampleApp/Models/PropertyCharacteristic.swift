//
//  PropertyCharacteristic.swift
//  rxswiftExampleApp
//
//  Created by Serhiy on 2/20/18.
//  Copyright © 2018 Serhiy. All rights reserved.
//

import Foundation

public enum PropertiesType: String {
    case MaxAmmo = "Maximum ammunition, pcs."
    case Damage = "Damage, HP"
    case Penetration = "Armor penetration, mm"
    case FireRate = "Rate of fire, rds/min"
    case ReloadTime = "Reload time, sec"
    case DamagePerMinute = "Damage per minute, HP/min"
    case AimTime = "Tool speed, sec"
    case TraverseSpeed = "Arnament tool speed, degrees/sec"
    case MoveArcDown = "UVN down, degrees"
    case MoveArcUp = "UVN up, degrees"
    case MinStrength = "Min. strength, HP"
    case TurretFront = "Turret, front, mm"
    case TurretSides = "Turret, sides, mm"
    case TurretRear = "Turret, rear, mm"
    case HullFront = "Hull, front, mm"
    case HullSides = "Hull, sides, mm"
    case HullRear = "Hull, rear, mm"
    case EnginePower = "Engine power, h. p."
    case MaxSpeed = "Max. speed, cm/h"
    case TurretTraverseSpeed = "Traverse speed, degree/sec"
    case TurretToolSpeed = "Turret tool speed, degree/sec"
    case MaxWeight = "Max. weight, t"
    case Range = "Range, m"
    case SignalRange = "Signal range, m"
    
    static let allValues = [MaxAmmo, Damage, Penetration, FireRate, ReloadTime, DamagePerMinute, AimTime, TraverseSpeed,
                            MoveArcDown, MoveArcUp, MinStrength, TurretFront, TurretSides, TurretRear, HullFront, HullSides, HullRear,
                            EnginePower, MaxSpeed, TurretTraverseSpeed, TurretToolSpeed, MaxWeight, Range, SignalRange]
}

class PropertyCharacteristic {
    var name: String
    var type: PropertiesType
    var value: Float = 0
    var lowerValue: Float = 0
    var equipment: EquipmentType
    var upperValue: Float = 0
    
    init(with model: EquipmentType, and type: PropertiesType) {
        self.type = type
        self.name = type.rawValue
        self.equipment = model
        self.create(from: model, and: type)
    }
    
    private func create(from model: EquipmentType, and type: PropertiesType) {
        let properties = GunProperties(data: model.defaultProfile.ammo)
        
        switch type {
        case .MaxAmmo:
            self.value = Float(model.defaultProfile.maxAmmo)
        case .Damage:
            let properties = GunProperties(data: model.defaultProfile.ammo)
            if let data = properties.getProperties() {
                self.value = data.damage
            }
        case .Penetration:
            if let data = properties.getProperties() {
                self.value = data.penetration
            }
        case .FireRate:
            if let fireRate = model.defaultProfile.gun.fireRate {
                self.value = fireRate
            }
        case .ReloadTime:
            if let reloadTime = model.defaultProfile.gun.reloadtime {
                self.value = reloadTime
            }
        case .DamagePerMinute:
            if let fireRate = model.defaultProfile.gun.fireRate, let data = properties.getProperties() {
                self.value = fireRate * data.damage
            }
        case .AimTime:
            if let aimTime = model.defaultProfile.gun.aimTime {
                self.value = aimTime
            }
        case .TraverseSpeed:
            self.value = Float(model.defaultProfile.gun.traverseSpeed)
        case .MoveArcUp:
            self.value = Float(model.defaultProfile.gun.moveUpArc)
        case .MoveArcDown:
            self.value = Float(model.defaultProfile.gun.moveDownArc)
        case .MinStrength:
            self.value = Float(model.defaultProfile.hp)
        case .TurretFront:
            if let front = model.defaultProfile.armor.turret?.front {
                self.value = Float(front)
            }
        case .TurretRear:
            if let rear = model.defaultProfile.armor.turret?.rear {
                self.value = Float(rear)
            }
        case .TurretSides:
            if let sides = model.defaultProfile.armor.turret?.sides {
                self.value = Float(sides)
            }
        case .HullFront:
            if let front = model.defaultProfile.armor.hull?.front {
                self.value = Float(front)
            }
        case .HullRear:
            if let rear = model.defaultProfile.armor.hull?.rear {
                self.value = Float(rear)
            }
        case .HullSides:
            if let sides = model.defaultProfile.armor.hull?.sides {
                self.value = Float(sides)
            }
        case .EnginePower:
            self.value = Float(model.defaultProfile.engine.power)
        case .MaxSpeed:
            self.value = Float(model.defaultProfile.speedForward)
        case .TurretTraverseSpeed:
            if let traverseSpeed = model.defaultProfile.suspension.traverse_speed {
                self.value = Float(traverseSpeed)
            }
        case .TurretToolSpeed:
            if let traverseSpeed = model.defaultProfile.turret.traverseSpeed {
                self.value = Float(traverseSpeed)
            }
        case .MaxWeight:
            self.value = Float(model.defaultProfile.maxWeight) / 1000.0
        case .SignalRange:
            self.value = Float(model.defaultProfile.radio.signalRange)
        case .Range:
            if let viewRange = model.defaultProfile.turret.viewRange {
                self.value = Float(viewRange)
            }
        }
    }
    
}
