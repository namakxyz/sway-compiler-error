contract;

use std::{
    bytes::Bytes,
};

storage {
    my_storagemap: StorageMap<b256,b256> = StorageMap {},
}

abi MyContract {
    #[storage(read,write)]
    fn test_function(nbr: u32);
}

impl MyContract for Contract {
    #[storage(read, write)]
    fn test_function(nbr: u32) {
        let key2: b256 = u32_to_bytes32(nbr).into();

        let key1: b256 = key2 >> 8;
        let val = storage.my_storagemap.get(key1).unwrap();

        let key2_bytes: Bytes = Bytes::from(key2);
        let u8_vec: Vec<u8> = key2_bytes.into_vec_u8();

        let arr0: [u8; 8] = [u8_vec.get(31).unwrap(), u8_vec.get(30).unwrap(), u8_vec.get(29).unwrap(), u8_vec.get(28).unwrap(), u8_vec.get(27).unwrap(), u8_vec.get(26).unwrap(), u8_vec.get(25).unwrap(), u8_vec.get(24).unwrap()];
        let arr1: [u8; 8] = [u8_vec.get(23).unwrap(), u8_vec.get(22).unwrap(), u8_vec.get(21).unwrap(), u8_vec.get(20).unwrap(), u8_vec.get(19).unwrap(), u8_vec.get(18).unwrap(), u8_vec.get(17).unwrap(), u8_vec.get(16).unwrap()];
        let arr2: [u8; 8] = [u8_vec.get(15).unwrap(), u8_vec.get(14).unwrap(), u8_vec.get(13).unwrap(), u8_vec.get(12).unwrap(), u8_vec.get(11).unwrap(), u8_vec.get(10).unwrap(), u8_vec.get(9).unwrap(), u8_vec.get(8).unwrap()];
        let arr3: [u8; 8] = [u8_vec.get(7).unwrap(),  u8_vec.get(6).unwrap(),  u8_vec.get(5).unwrap(),  u8_vec.get(4).unwrap(),  u8_vec.get(3).unwrap(),  u8_vec.get(2).unwrap(),  u8_vec.get(1).unwrap(), u8_vec.get(0).unwrap()];
    }
}

fn u32_to_bytes32(id: u32) -> Bytes {
    let mut bytes = Bytes::with_capacity(32);
    let idu8: [u8; 4] = u32_to_array_of_u8(id >> 8);

    let mut i = 0;
    while i < 28 {
        bytes.push(0u8);
        i += 1;
    }

    bytes.push(idu8[0]);
    bytes.push(idu8[1]);
    bytes.push(idu8[2]);
    bytes.push(idu8[3]);

    bytes
}

fn u32_to_array_of_u8(number: u32) -> [u8; 4] {
    let b1: u8 = ((number >> 24) & 0xff);
    let b2: u8 = ((number >> 16) & 0xff);
    let b3: u8 = ((number >> 8) & 0xff);
    let b4: u8 = (number & 0xff);
    return [b1, b2, b3, b4]
}