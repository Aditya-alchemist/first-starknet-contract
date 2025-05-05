
#[starknet::interface]
trait ContractInterface<TContractState> {
    fn set(ref self: TContractState, value: u32);
    fn get(self: @TContractState) -> u32;
}
 
#[starknet::contract]
mod Contract {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    use super::ContractInterface;
 
    #[storage]
    pub struct Storage {
        pub value: u32,
    }
 
    
    #[abi(embed_v0)]
    pub impl ContractImpl of ContractInterface<ContractState> {
       
        fn set(ref self: ContractState, value: u32) {
            self.value.write(increment(value));
        }
 
       
        fn get(self: @ContractState) -> u32 {
            self._read_value()
        }
    }
 
  
    #[generate_trait]
    pub impl Internal of InternalTrait {
      
        fn _read_value(self: @ContractState) -> u32 {
            self.value.read()
        }
    }
 
   
    pub fn increment(value: u32) -> u32 {
        value + 1
    }
}