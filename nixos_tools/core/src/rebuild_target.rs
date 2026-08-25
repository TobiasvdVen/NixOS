use std::net::Ipv4Addr;

pub enum RebuildTarget
{
    ThisMachine,
    Remote
    {
        ip: Ipv4Addr
    }
}
