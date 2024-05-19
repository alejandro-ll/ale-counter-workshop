use starknet::ContractAddress;

#[starknet::interface]
pub trait ICounter<TContractState> {
    fn get_counter(self: @TContractState) -> u32;
    fn inc_counter(ref self: TContractState);
}

#[starknet::contract]
mod Counter {
    use super::{ICounter};
    use starknet::{ContractAddress};
    use kill_switch::{ IKillSwitchDispatcher, IKillSwitchDispatcherTrait };
    #[storage]
    struct Storage {
        counter: u32,
        kill_switch: IKillSwitchDispatcher,
    }

    #[constructor]
    fn constructor(ref self: ContractState, value: u32, kill_switch_address: ContractAddress) {
        self.counter.write(value);
        self.kill_switch.write(IKillSwitchDispatcher{ contract_address: kill_switch_address });
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        CounterIncreased: CounterIncreased,
    }

    #[derive(Drop, starknet::Event)]
    struct CounterIncreased {
        counter: u32
    }

    #[abi(embed_v0)]
    impl Counter of ICounter<ContractState> {
        fn get_counter(self: @ContractState) -> u32 {
            return self.counter.read();
        }
        fn inc_counter(ref self: ContractState) {
            if (self.kill_switch.read().is_active()){
                self.counter.write(self.counter.read() + 1);
                self.emit(CounterIncreased { counter: self.counter.read() });

            }
        }
    }
}