use std::fmt::Display;

#[derive(Clone, Default, Debug, PartialEq, Eq)]
pub enum RebuildMode
{
    #[default]
    Switch,

    Test,

    DryActivate
}

impl Display for RebuildMode
{
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result
    {
        write!(
            f,
            "{}",
            match self
            {
                RebuildMode::Switch => "switch",
                RebuildMode::Test => "test",
                RebuildMode::DryActivate => "dry-activate"
            }
        )
    }
}
