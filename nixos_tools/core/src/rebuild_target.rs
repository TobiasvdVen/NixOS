use std::net::Ipv4Addr;

#[derive(Debug)]
pub enum RebuildTarget
{
    ThisMachine,
    Remote
    {
        ip: Ipv4Addr
    }
}
