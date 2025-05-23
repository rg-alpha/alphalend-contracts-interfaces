// Copyright (c) Seed Labs

#[allow(unused_field, unused_variable,unused_type_parameter, unused_mut_parameter)]
/// Positions Module
/// Module for managing positions on bluefin spot. A user is required to first open a position
/// on bluefin spot's pools before being able to provide liquidity. 
/// Each position is a SUI object/NFT and the owner of the object/NFT is the liquidity provider
module bluefin_spot::position {
    use sui::object::{ Self,UID, ID};
    use std::string::{Self,String};
    use integer_mate::i32::{Self,I32};
    use std::type_name::{Self,TypeName};
    use sui::tx_context::{TxContext};
    //===========================================================//
    //                          Structs                          //
    //===========================================================//

    /// Bluefrin Spot position struct
    struct Position has key, store {
        id: UID,
        pool_id: ID,
        lower_tick: I32,
        upper_tick: I32,
        fee_rate: u64,
        liquidity: u128,
        fee_growth_coin_a : u128, 
        fee_growth_coin_b : u128, 
        token_a_fee: u64, 
        token_b_fee: u64, 
        name: String,
        coin_type_a: String,
        coin_type_b: String,
        description: String,
        image_url: String,
        position_index: u128,
        reward_infos: vector<PositionRewardInfo>
    }

    /// The rewards info of an individual reward coin. Each position stores a vector of reward info for
    /// each reward token that is given out by the pool on which the position exists
    struct PositionRewardInfo has copy, drop, store {
        reward_growth_inside_last: u128,
        coins_owed_reward: u64,
    }
       

    //===========================================================//
    //                        Public Funcitons                   //
    //===========================================================//


    public fun lower_tick(position: &Position): I32 {
        position.lower_tick
    }

    public fun upper_tick(position: &Position): I32 {
        position.upper_tick
    }

    public fun liquidity(position: &Position): u128 {
        position.liquidity
    }

    public fun pool_id(position: &Position): ID {
        position.pool_id
    }

    public fun get_accrued_fee(position: &Position): (u64, u64){
        (position.token_a_fee, position.token_b_fee)
    }

    public fun coins_owed_reward(position: &Position, index: u64) : u64 {
        abort 0
    }

    public fun is_empty(position: &Position) : bool {
        abort 0
    }

    #[test_only]
    public fun create_position_for_testing<A,B>(pool_id: ID, ctx: &mut TxContext) : Position {
        let position = Position {
            id: object::new(ctx),
            pool_id: pool_id,
            lower_tick: i32::zero(),
            upper_tick: i32::zero(),
            fee_rate: 0,
            liquidity: 0,
            fee_growth_coin_a: 0,
            fee_growth_coin_b: 0,
            token_a_fee: 0,
            token_b_fee: 0,
            name: string::utf8(b"Pool Name"),
            coin_type_a: string::utf8(b"Coin Type A"),
            coin_type_b: string::utf8(b"Coin Type B"),
            description: string::utf8(b"Pool Description"),
            image_url: string::utf8(b"Pool Image URL"),
            position_index: 0,
            reward_infos: vector[]
        };
        position
    }

    

    #[test_only]
    public fun set_liquidity(position: &mut Position, liquidity: u128) {
        position.liquidity = liquidity;
    }
    
}
