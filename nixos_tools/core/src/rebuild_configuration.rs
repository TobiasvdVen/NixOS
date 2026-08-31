use crate::flake::NixosConfiguration;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct RebuildConfiguration
{
    pub name: String,
    pub nixos_configuration: NixosConfiguration
}
